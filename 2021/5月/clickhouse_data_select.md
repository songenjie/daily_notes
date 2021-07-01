```c++

            for (std::deque<MarkRange>::iterator iter = ranges.ranges.begin() + 1; iter != ranges.ranges.end();)
            {
                auto befor_range = iter - 1;
                LOG_INFO(
                    log,
                    "songenjie s3 query optimization ranges {}:{}-{}:{}",
                    befor_range->begin,
                    befor_range->end,
                    iter->begin,
                    iter->end);
                LOG_INFO(log, "songenjie source {}", iter->end + befor_range->end - iter->begin - befor_range->begin);
                LOG_INFO(log, "songenjie all/2 {}", (iter->end - befor_range->begin) * 2);
                if (iter->end + befor_range->end - iter->begin - befor_range->begin > (iter->end - befor_range->begin) / 2 && ( iter->begin - befor_range->end) < 40)
                {
                    LOG_INFO(
                        log,
                        "songenjie s3 query optimization merge ranges {}:{}-{}:{}",
                        befor_range->begin,
                        befor_range->end,
                        iter->begin,
                        iter->end);
                    befor_range->end = iter->end;
                    iter = ranges.ranges.erase(iter);
                    continue;
                }
                iter++;
            }


-DBUILD_ONLY="s3" -DCUSTOM_MEMORY_MANAGEMENT=0 -DSTATIC_LINKING=1

        auto num_split_marks = sum_marks / settings.max_threads;
        LOG_INFO(log, "songenjie num split marks {}", num_split_marks);
        if (settings.s3_query_optimization && num_split_marks > 0 && sum_ranges < settings.max_threads)
        {
            LOG_DEBUG(log, "songenjie query optimization");
            sum_ranges = 0;
            sum_marks = 0;
            for (auto & part_with_range : parts_with_ranges)
            {
                MarkRanges res;
                for (auto & range : part_with_range.ranges)
                {
                    if (range.end - range.begin > num_split_marks)
                    {
                        for (auto start_mark = range.begin; start_mark < range.end;)
                        {
                            auto end_mark = start_mark + 2 * num_split_marks < range.end ? start_mark + num_split_marks : range.end;
                            end_mark = end_mark < range.end ? end_mark : range.end;
                            LOG_DEBUG(log, "songenjie push back range {}:{}", start_mark, end_mark);
                            res.push_back(MarkRange(start_mark, end_mark));
                            start_mark = end_mark;
                        }
                    }
                    else
                        res.push_back(range);
                }
                part_with_range.ranges = res;
            }
            for (size_t part_index = 0; part_index < parts.size(); ++part_index)
            {
                auto & part = parts_with_ranges[part_index];
                sum_ranges += part.ranges.size();
                sum_marks += part.getMarksCount();
            }
        }



    LOG_DEBUG(log, "songenjie Selected {}/{} parts by partition key, {} parts by primary key, {}/{} marks by primary key, {} marks to read from {} ranges",
        parts.size(), total_parts, parts_with_ranges.size(),
        sum_marks_pk.load(std::memory_order_relaxed),
        total_marks_pk.load(std::memory_order_relaxed),
        sum_marks, sum_ranges);
```





Merge Read Pool

```c++
    {
        LOG_DEBUG(log,"songenjie s3 query optimization thread size {} ", threads);
        DB::UInt64 thread_index = 0;
        for (auto part : parts)
            for (auto range : part.ranges)
            {
                LOG_INFO(log," songenjie part index {} , range {}:{} ", part.part_index_in_query, range.begin, range.end);
                threads_tasks[thread_index % threads].parts_and_ranges.push_back({part.part_index_in_query, {range}});
                threads_tasks[thread_index % threads].sum_marks_in_parts.push_back(range.end - range.begin);
                if (part.getMarksCount() != 0)
                    remaining_thread_tasks.insert(thread_index % threads);
                thread_index++;
            }
        return;
    }
```

