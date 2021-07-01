```c++


Pipe ReadFromMergeTree::readFromPool(
    RangesInDataParts parts_with_range,
    Names required_columns,
    size_t max_streams,
    size_t min_marks_for_concurrent_read,
    bool use_uncompressed_cache)
{
   auto pool = std::make_shared<MergeTreeReadPool>(
    max_streams,
    sum_marks,
    min_marks_for_concurrent_read,
    std::move(parts_with_range),
    data,
    metadata_snapshot,
    prewhere_info,
    true,
    required_columns,
    backoff_settings,
    settings.preferred_block_size_bytes,
    false);
  
    for (size_t i = 0; i < max_streams; ++i)
    {
        auto source = std::make_shared<MergeTreeThreadSelectBlockInputProcessor>(
            i, pool, min_marks_for_concurrent_read, max_block_size,
            settings.preferred_block_size_bytes, settings.preferred_max_column_in_block_size_bytes,
            data, metadata_snapshot, use_uncompressed_cache,
            prewhere_info, reader_settings, virt_column_names);

        if (i == 0)
        {
            /// Set the approximate number of rows for the first source only
            source->addTotalRowsApprox(total_rows);
        }

        pipes.emplace_back(std::move(source));
    }

    return Pipe::unitePipes(std::move(pipes))
}
  












```

