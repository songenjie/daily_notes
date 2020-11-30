format version: 4
create_time: 2020-11-13 15:44:35
source replica: 02
block_id: 
merge
20191031_148_153_1
20191031_154_159_1
into
20191031_148_159_2
deduplicate: 0







```c++
void ReplicatedMergeTreeBlockOutputStream::write(const Block & block)
{
    last_block_is_duplicate = false;
    storage.delayInsertOrThrowIfNeeded(&storage.partial_shutdown_event);
    auto zookeeper = storage.getZooKeeper();
    assertSessionIsNotExpired(zookeeper);
    /** If write is with quorum, then we check that the required number of replicas is now live,
      *  and also that for all previous parts for which quorum is required, this quorum is reached.
      * And also check that during the insertion, the replica was not reinitialized or disabled (by the value of `is_active` node).
      * TODO Too complex logic, you can do better.
      */
    if (quorum)
        checkQuorumPrecondition(zookeeper);
    auto part_blocks = storage.writer.splitBlockIntoParts(block, max_parts_per_block, metadata_snapshot);
    for (auto & current_block : part_blocks)
    {
        Stopwatch watch;
        /// Write part to the filesystem under temporary name. Calculate a checksum.
        MergeTreeData::MutableDataPartPtr part = storage.writer.writeTempPart(current_block, metadata_snapshot);
        String block_id;
        if (deduplicate)
        {
            SipHash hash;
            part->checksums.computeTotalChecksumDataOnly(hash);
            union
            {
                char bytes[16];
                UInt64 words[2];
            } hash_value;
            hash.get128(hash_value.bytes);
            /// We add the hash from the data and partition identifier to deduplication ID.
            /// That is, do not insert the same data to the same partition twice.
            block_id = part->info.partition_id + "_" + toString(hash_value.words[0]) + "_" + toString(hash_value.words[1]);
            LOG_DEBUG(log, "Wrote block with ID '{}', {} rows", block_id, current_block.block.rows());
        }
        else
        {
            LOG_DEBUG(log, "Wrote block with {} rows", current_block.block.rows());
        }
        try
        {
            //block id == part 
            commitPart(zookeeper, part, block_id);
            /// Set a special error code if the block is duplicate
            int error = (deduplicate && last_block_is_duplicate) ? ErrorCodes::INSERT_WAS_DEDUPLICATED : 0;
            PartLog::addNewPart(storage.global_context, part, watch.elapsed(), ExecutionStatus(error));
        }
        catch (...)
        {
            PartLog::addNewPart(storage.global_context, part, watch.elapsed(), ExecutionStatus::fromCurrentException(__PRETTY_FUNCTION__));
            throw;
        }
    }
}
```

