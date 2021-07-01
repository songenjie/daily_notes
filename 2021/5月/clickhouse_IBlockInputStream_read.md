

![preview](https://pic2.zhimg.com/v2-b2836c9e722f3c9aca9df6230ac2fe85_r.jpg)

```c++
/// It's safe to access children without mutex as long as these methods are called before first call to `read()` or `readPrefix()`
Block IBlockInputStream::read();
  
Block readImpl() override;

void ISource::work();

std::optional<Chunk> ISource::tryGenerate();

Chunk MergeTreeBaseSelectProcessor::generate();

Chunk MergeTreeBaseSelectProcessor::readFromPart();

Chunk MergeTreeBaseSelectProcessor::readFromPartImpl();

MergeTreeRangeReader::ReadResult MergeTreeRangeReader::read(size_t max_rows, MarkRanges & ranges);

/// Returns the number of rows added to block.
size_t MergeTreeRangeReader::DelayedStream::read(Columns & columns, size_t from_mark, size_t offset, size_t num_rows);

size_t MergeTreeRangeReader::DelayedStream::finalize(Columns & columns);

size_t MergeTreeRangeReader::DelayedStream::readRows(Columns & columns, size_t num_rows);

/// Return the number of rows has been read or zero if there is no columns to read.
/// If continue_reading is true, continue reading from last state, otherwise seek to from_mark
size_t MergeTreeReaderWide::readRows(size_t from_mark, bool continue_reading, size_t max_rows_to_read, Columns & res_columns);

void MergeTreeReaderWide::readData(
    const NameAndTypePair & name_and_type, ColumnPtr & column,
    size_t from_mark, bool continue_reading, size_t max_rows_to_read,
    ISerialization::SubstreamsCache & cache);

void MergeTreeReaderStream::seekToMark(size_t index);

void CompressedReadBufferFromFile::seek(size_t offset_in_compressed_file, size_t offset_in_decompressed_block);

bool CompressedReadBufferFromFile::nextImpl();

/// Read compressed data into compressed_buffer. Get size of decompressed data from block header. Checksum if need.
/// Returns number of compressed bytes read.
size_t CompressedReadBufferBase::readCompressedData(size_t & size_decompressed, size_t & size_compressed_without_checksum, bool always_copy);

    /** Unlike std::istream, it returns true if all data was read
      *  (and not in case there was an attempt to read after the end).
      * If at the moment the position is at the end of the buffer, it calls the next() method.
      * That is, it has a side effect - if the buffer is over, then it updates it and set the position to the beginning.
      *
      * Try to read after the end should throw an exception.
      */
    bool ALWAYS_INLINE eof()
    {
        return !hasPendingData() && !next();
    }


    /** read next data and fill a buffer with it; set position to the beginning;
      * return `false` in case of end, `true` otherwise; throw an exception, if something is wrong
      */
    bool next()
    {
        assert(!hasPendingData());
        assert(position() <= working_buffer.end());

        bytes += offset();
        bool res = nextImpl();
        if (!res)
            working_buffer = Buffer(pos, pos);
        else
            pos = working_buffer.begin() + nextimpl_working_buffer_offset;
        nextimpl_working_buffer_offset = 0;

        assert(position() <= working_buffer.end());

        return res;
    }

```



![企业微信截图_16221203065408](企业微信截图_16221203065408.png)





```c++
DB::MergeTreeRangeReader::DelayedStream::readRows(std::__1::vector<COW<DB::IColumn>::immutable_ptr<DB::IColumn>, std::__1::allocator<COW<DB::IColumn>::immutable_ptr<DB::IColumn> > >&, unsigned long) MergeTreeRangeReader.cpp:73
DB::MergeTreeRangeReader::DelayedStream::finalize(std::__1::vector<COW<DB::IColumn>::immutable_ptr<DB::IColumn>, std::__1::allocator<COW<DB::IColumn>::immutable_ptr<DB::IColumn> > >&) MergeTreeRangeReader.cpp:148
DB::MergeTreeRangeReader::Stream::finalize(std::__1::vector<COW<DB::IColumn>::immutable_ptr<DB::IColumn>, std::__1::allocator<COW<DB::IColumn>::immutable_ptr<DB::IColumn> > >&) MergeTreeRangeReader.cpp:259
DB::MergeTreeRangeReader::startReadingChain(unsigned long, std::__1::deque<DB::MarkRange, std::__1::allocator<DB::MarkRange> >&) MergeTreeRangeReader.cpp:764
DB::MergeTreeRangeReader::read(unsigned long, std::__1::deque<DB::MarkRange, std::__1::allocator<DB::MarkRange> >&) MergeTreeRangeReader.cpp:715
DB::MergeTreeBaseSelectProcessor::readFromPartImpl() MergeTreeBaseSelectProcessor.cpp:148
DB::MergeTreeBaseSelectProcessor::readFromPart() MergeTreeBaseSelectProcessor.cpp:196
DB::MergeTreeBaseSelectProcessor::generate() MergeTreeBaseSelectProcessor.cpp:59
DB::ISource::tryGenerate() ISource.cpp:79
DB::ISource::work() ISource.cpp:53
DB::SourceWithProgress::work() SourceWithProgress.cpp:36
DB::executeJob(DB::IProcessor*) PipelineExecutor.cpp:80
DB::PipelineExecutor::addJob(DB::ExecutingGraph::Node*)::$_0::operator()() const PipelineExecutor.cpp:97
decltype(std::__1::forward<DB::PipelineExecutor::addJob(DB::ExecutingGraph::Node*)::$_0&>(fp)()) std::__1::__invoke<DB::PipelineExecutor::addJob(DB::ExecutingGraph::Node*)::$_0&>(DB::PipelineExecutor::addJob(DB::ExecutingGraph::Node*)::$_0&) type_traits:3676
void std::__1::__invoke_void_return_wrapper<void>::__call<DB::PipelineExecutor::addJob(DB::ExecutingGraph::Node*)::$_0&>(DB::PipelineExecutor::addJob(DB::ExecutingGraph::Node*)::$_0&) __functional_base:348
std::__1::__function::__default_alloc_func<DB::PipelineExecutor::addJob(DB::ExecutingGraph::Node*)::$_0, void ()>::operator()() functional:1608
void std::__1::__function::__policy_invoker<void ()>::__call_impl<std::__1::__function::__default_alloc_func<DB::PipelineExecutor::addJob(DB::ExecutingGraph::Node*)::$_0, void ()> >(std::__1::__function::__policy_storage const*) functional:2089
std::__1::__function::__policy_func<void ()>::operator()() const functional:2221
std::__1::function<void ()>::operator()() const functional:2560
DB::PipelineExecutor::executeStepImpl(unsigned long, unsigned long, std::__1::atomic<bool>*) PipelineExecutor.cpp:586
DB::PipelineExecutor::executeSingleThread(unsigned long, unsigned long) PipelineExecutor.cpp:474
DB::PipelineExecutor::executeImpl(unsigned long) PipelineExecutor.cpp:813
DB::PipelineExecutor::execute(unsigned long) PipelineExecutor.cpp:396
DB::threadFunction(DB::PullingAsyncPipelineExecutor::Data&, std::__1::shared_ptr<DB::ThreadGroupStatus>, unsigned long) PullingAsyncPipelineExecutor.cpp:80
DB::PullingAsyncPipelineExecutor::pull(DB::Chunk&, unsigned long long)::$_0::operator()() const PullingAsyncPipelineExecutor.cpp:107
decltype(std::__1::forward<DB::PullingAsyncPipelineExecutor::pull(DB::Chunk&, unsigned long long)::$_0&>(fp)()) std::__1::__invoke_constexpr<DB::PullingAsyncPipelineExecutor::pull(DB::Chunk&, unsigned long long)::$_0&>(DB::PullingAsyncPipelineExecutor::pull(DB::Chunk&, unsigned long long)::$_0&) type_traits:3682
decltype(auto) std::__1::__apply_tuple_impl<DB::PullingAsyncPipelineExecutor::pull(DB::Chunk&, unsigned long long)::$_0&, std::__1::tuple<>&>(DB::PullingAsyncPipelineExecutor::pull(DB::Chunk&, unsigned long long)::$_0&, std::__1::tuple<>&, std::__1::__tuple_indices<>) tuple:1415
decltype(auto) std::__1::apply<DB::PullingAsyncPipelineExecutor::pull(DB::Chunk&, unsigned long long)::$_0&, std::__1::tuple<>&>(DB::PullingAsyncPipelineExecutor::pull(DB::Chunk&, unsigned long long)::$_0&, std::__1::tuple<>&) tuple:1424
ThreadFromGlobalPool::ThreadFromGlobalPool<DB::PullingAsyncPipelineExecutor::pull(DB::Chunk&, unsigned long long)::$_0>(DB::PullingAsyncPipelineExecutor::pull(DB::Chunk&, unsigned long long)::$_0&&)::'lambda'()::operator()() ThreadPool.h:178
decltype(std::__1::forward<DB::PullingAsyncPipelineExecutor::pull(DB::Chunk&, unsigned long long)::$_0>(fp)()) std::__1::__invoke<ThreadFromGlobalPool::ThreadFromGlobalPool<DB::PullingAsyncPipelineExecutor::pull(DB::Chunk&, unsigned long long)::$_0>(DB::PullingAsyncPipelineExecutor::pull(DB::Chunk&, unsigned long long)::$_0&&)::'lambda'()&>(DB::PullingAsyncPipelineExecutor::pull(DB::Chunk&, unsigned long long)::$_0&&) type_traits:3676
void std::__1::__invoke_void_return_wrapper<void>::__call<ThreadFromGlobalPool::ThreadFromGlobalPool<DB::PullingAsyncPipelineExecutor::pull(DB::Chunk&, unsigned long long)::$_0>(DB::PullingAsyncPipelineExecutor::pull(DB::Chunk&, unsigned long long)::$_0&&)::'lambda'()&>(ThreadFromGlobalPool::ThreadFromGlobalPool<DB::PullingAsyncPipelineExecutor::pull(DB::Chunk&, unsigned long long)::$_0>(DB::PullingAsyncPipelineExecutor::pull(DB::Chunk&, unsigned long long)::$_0&&)::'lambda'()&) __functional_base:348
std::__1::__function::__default_alloc_func<ThreadFromGlobalPool::ThreadFromGlobalPool<DB::PullingAsyncPipelineExecutor::pull(DB::Chunk&, unsigned long long)::$_0>(DB::PullingAsyncPipelineExecutor::pull(DB::Chunk&, unsigned long long)::$_0&&)::'lambda'(), void ()>::operator()() functional:1608
void std::__1::__function::__policy_invoker<void ()>::__call_impl<std::__1::__function::__default_alloc_func<ThreadFromGlobalPool::ThreadFromGlobalPool<DB::PullingAsyncPipelineExecutor::pull(DB::Chunk&, unsigned long long)::$_0>(DB::PullingAsyncPipelineExecutor::pull(DB::Chunk&, unsigned long long)::$_0&&)::'lambda'(), void ()> >(std::__1::__function::__policy_storage const*) functional:2089
std::__1::__function::__policy_func<void ()>::operator()() const functional:2221
std::__1::function<void ()>::operator()() const functional:2560
ThreadPoolImpl<std::__1::thread>::worker(std::__1::__list_iterator<std::__1::thread, void*>) ThreadPool.cpp:247
void ThreadPoolImpl<std::__1::thread>::scheduleImpl<void>(std::__1::function<void ()>, int, std::__1::optional<unsigned long long>)::'lambda1'()::operator()() const ThreadPool.cpp:124
decltype(std::__1::forward<void>(fp)()) std::__1::__invoke<void ThreadPoolImpl<std::__1::thread>::scheduleImpl<void>(std::__1::function<void ()>, int, std::__1::optional<unsigned long long>)::'lambda1'()>(void&&) type_traits:3676
void std::__1::__thread_execute<std::__1::unique_ptr<std::__1::__thread_struct, std::__1::default_delete<std::__1::__thread_struct> >, void ThreadPoolImpl<std::__1::thread>::scheduleImpl<void>(std::__1::function<void ()>, int, std::__1::optional<unsigned long long>)::'lambda1'()>(std::__1::tuple<void, void ThreadPoolImpl<std::__1::thread>::scheduleImpl<void>(std::__1::function<void ()>, int, std::__1::optional<unsigned long long>)::'lambda1'()>&, std::__1::__tuple_indices<>) thread:280
void* std::__1::__thread_proxy<std::__1::tuple<std::__1::unique_ptr<std::__1::__thread_struct, std::__1::default_delete<std::__1::__thread_struct> >, void ThreadPoolImpl<std::__1::thread>::scheduleImpl<void>(std::__1::function<void ()>, int, std::__1::optional<unsigned long long>)::'lambda1'()> >(void*) thread:291
_pthread_start 0x00007fff2037f950
thread_start 0x00007fff2037b47b
```

