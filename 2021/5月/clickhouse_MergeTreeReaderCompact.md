<img src="image-20210604113515947.png" alt="image-20210604113515947" style="zoom:50%;" />

```c++
DB::ReadFromMergeTree::ReadFromMergeTree(DB::MergeTreeData const&, std::__1::shared_ptr<DB::StorageInMemoryMetadata const>, std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >, std::__1::vector<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >, std::__1::allocator<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > > >, std::__1::vector<DB::RangesInDataPart, std::__1::allocator<DB::RangesInDataPart> >, std::__1::unique_ptr<std::__1::vector<DB::ReadFromMergeTree::IndexStat, std::__1::allocator<DB::ReadFromMergeTree::IndexStat> >, std::__1::default_delete<std::__1::vector<DB::ReadFromMergeTree::IndexStat, std::__1::allocator<DB::ReadFromMergeTree::IndexStat> > > >, std::__1::shared_ptr<DB::PrewhereInfo>, std::__1::vector<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >, std::__1::allocator<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > > >, DB::ReadFromMergeTree::Settings, unsigned long, DB::ReadFromMergeTree::ReadType) ReadFromMergeTree.cpp:25
DB::ReadFromMergeTree::ReadFromMergeTree(DB::MergeTreeData const&, std::__1::shared_ptr<DB::StorageInMemoryMetadata const>, std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >, std::__1::vector<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >, std::__1::allocator<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > > >, std::__1::vector<DB::RangesInDataPart, std::__1::allocator<DB::RangesInDataPart> >, std::__1::unique_ptr<std::__1::vector<DB::ReadFromMergeTree::IndexStat, std::__1::allocator<DB::ReadFromMergeTree::IndexStat> >, std::__1::default_delete<std::__1::vector<DB::ReadFromMergeTree::IndexStat, std::__1::allocator<DB::ReadFromMergeTree::IndexStat> > > >, std::__1::shared_ptr<DB::PrewhereInfo>, std::__1::vector<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >, std::__1::allocator<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > > >, DB::ReadFromMergeTree::Settings, unsigned long, DB::ReadFromMergeTree::ReadType) ReadFromMergeTree.cpp:40
std::__1::__unique_if<DB::ReadFromMergeTree>::__unique_single std::__1::make_unique<DB::ReadFromMergeTree, DB::MergeTreeData const&, std::__1::shared_ptr<DB::StorageInMemoryMetadata const> const&, std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > const&, std::__1::vector<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >, std::__1::allocator<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > > > const&, std::__1::vector<DB::RangesInDataPart, std::__1::allocator<DB::RangesInDataPart> >, std::__1::unique_ptr<std::__1::vector<DB::ReadFromMergeTree::IndexStat, std::__1::allocator<DB::ReadFromMergeTree::IndexStat> >, std::__1::default_delete<std::__1::vector<DB::ReadFromMergeTree::IndexStat, std::__1::allocator<DB::ReadFromMergeTree::IndexStat> > > >, std::__1::shared_ptr<DB::PrewhereInfo> const&, std::__1::vector<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >, std::__1::allocator<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > > > const&, DB::ReadFromMergeTree::Settings&, unsigned long&, DB::ReadFromMergeTree::ReadType>(DB::MergeTreeData const&, std::__1::shared_ptr<DB::StorageInMemoryMetadata const> const&, std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > const&, std::__1::vector<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >, std::__1::allocator<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > > > const&, std::__1::vector<DB::RangesInDataPart, std::__1::allocator<DB::RangesInDataPart> >&&, std::__1::unique_ptr<std::__1::vector<DB::ReadFromMergeTree::IndexStat, std::__1::allocator<DB::ReadFromMergeTree::IndexStat> >, std::__1::default_delete<std::__1::vector<DB::ReadFromMergeTree::IndexStat, std::__1::allocator<DB::ReadFromMergeTree::IndexStat> > > >&&, std::__1::shared_ptr<DB::PrewhereInfo> const&, std::__1::vector<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >, std::__1::allocator<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > > > const&, DB::ReadFromMergeTree::Settings&, unsigned long&, DB::ReadFromMergeTree::ReadType&&) memory:2068
DB::MergeTreeDataSelectExecutor::spreadMarkRangesAmongStreams(std::__1::vector<DB::RangesInDataPart, std::__1::allocator<DB::RangesInDataPart> >&&, std::__1::unique_ptr<std::__1::vector<DB::ReadFromMergeTree::IndexStat, std::__1::allocator<DB::ReadFromMergeTree::IndexStat> >, std::__1::default_delete<std::__1::vector<DB::ReadFromMergeTree::IndexStat, std::__1::allocator<DB::ReadFromMergeTree::IndexStat> > > >, unsigned long, std::__1::vector<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >, std::__1::allocator<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > > > const&, std::__1::shared_ptr<DB::StorageInMemoryMetadata const> const&, unsigned long long, bool, DB::SelectQueryInfo const&, std::__1::vector<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >, std::__1::allocator<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > > > const&, DB::Settings const&, DB::MergeTreeReaderSettings const&, std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > const&) const MergeTreeDataSelectExecutor.cpp:1105
DB::MergeTreeDataSelectExecutor::readFromParts(std::__1::vector<std::__1::shared_ptr<DB::IMergeTreeDataPart const>, std::__1::allocator<std::__1::shared_ptr<DB::IMergeTreeDataPart const> > >, std::__1::vector<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >, std::__1::allocator<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > > > const&, std::__1::shared_ptr<DB::StorageInMemoryMetadata const> const&, DB::SelectQueryInfo const&, std::__1::shared_ptr<DB::Context>, unsigned long long, unsigned int, std::__1::unordered_map<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >, long long, std::__1::hash<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > >, std::__1::equal_to<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > >, std::__1::allocator<std::__1::pair<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > const, long long> > > const*) const MergeTreeDataSelectExecutor.cpp:918
DB::MergeTreeDataSelectExecutor::read(std::__1::vector<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >, std::__1::allocator<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > > > const&, std::__1::shared_ptr<DB::StorageInMemoryMetadata const> const&, DB::SelectQueryInfo const&, std::__1::shared_ptr<DB::Context>, unsigned long long, unsigned int, std::__1::unordered_map<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >, long long, std::__1::hash<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > >, std::__1::equal_to<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > >, std::__1::allocator<std::__1::pair<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > const, long long> > > const*) const MergeTreeDataSelectExecutor.cpp:163
DB::StorageMergeTree::read(DB::QueryPlan&, std::__1::vector<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >, std::__1::allocator<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > > > const&, std::__1::shared_ptr<DB::StorageInMemoryMetadata const> const&, DB::SelectQueryInfo&, std::__1::shared_ptr<DB::Context>, DB::QueryProcessingStage::Enum, unsigned long, unsigned int) StorageMergeTree.cpp:190
DB::InterpreterSelectQuery::executeFetchColumns(DB::QueryProcessingStage::Enum, DB::QueryPlan&) InterpreterSelectQuery.cpp:1806
DB::InterpreterSelectQuery::executeImpl(DB::QueryPlan&, std::__1::shared_ptr<DB::IBlockInputStream> const&, std::__1::optional<DB::Pipe>) InterpreterSelectQuery.cpp:998
DB::InterpreterSelectQuery::buildQueryPlan(DB::QueryPlan&) InterpreterSelectQuery.cpp:546
DB::InterpreterSelectWithUnionQuery::buildQueryPlan(DB::QueryPlan&) InterpreterSelectWithUnionQuery.cpp:244
DB::InterpreterSelectWithUnionQuery::execute() InterpreterSelectWithUnionQuery.cpp:311
DB::executeQueryImpl(char const*, char const*, std::__1::shared_ptr<DB::Context>, bool, DB::QueryProcessingStage::Enum, bool, DB::ReadBuffer*) executeQuery.cpp:561
DB::executeQuery(std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > const&, std::__1::shared_ptr<DB::Context>, bool, DB::QueryProcessingStage::Enum, bool) executeQuery.cpp:919
DB::TCPHandler::runImpl() TCPHandler.cpp:312
DB::TCPHandler::run() TCPHandler.cpp:1624
Poco::Net::TCPServerConnection::start() TCPServerConnection.cpp:43
Poco::Net::TCPServerDispatcher::run() TCPServerDispatcher.cpp:115
Poco::PooledThread::run() ThreadPool.cpp:199
Poco::(anonymous namespace)::RunnableHolder::run() Thread.cpp:55
Poco::ThreadImpl::runnableEntry(void*) Thread_POSIX.cpp:345
_pthread_start 0x00007fff2037f950
thread_start 0x00007fff2037b47b
```





```
INSERT INTO download
  SELECT
    now() + number * 60 AS when,
    2,
    rand() % 100000000 AS bytes
  FROM system.numbers
  LIMIT 10000;
```



















Read rows

```c++
DB::MergeTreeReaderCompact::readRows(unsigned long, bool, unsigned long, std::__1::vector<COW<DB::IColumn>::immutable_ptr<DB::IColumn>, std::__1::allocator<COW<DB::IColumn>::immutable_ptr<DB::IColumn> > >&) MergeTreeReaderCompact.cpp:134
DB::MergeTreeRangeReader::DelayedStream::readRows(std::__1::vector<COW<DB::IColumn>::immutable_ptr<DB::IColumn>, std::__1::allocator<COW<DB::IColumn>::immutable_ptr<DB::IColumn> > >&, unsigned long) MergeTreeRangeReader.cpp:75
DB::MergeTreeRangeReader::DelayedStream::finalize(std::__1::vector<COW<DB::IColumn>::immutable_ptr<DB::IColumn>, std::__1::allocator<COW<DB::IColumn>::immutable_ptr<DB::IColumn> > >&) MergeTreeRangeReader.cpp:148
DB::MergeTreeRangeReader::Stream::finalize(std::__1::vector<COW<DB::IColumn>::immutable_ptr<DB::IColumn>, std::__1::allocator<COW<DB::IColumn>::immutable_ptr<DB::IColumn> > >&) MergeTreeRangeReader.cpp:259
DB::MergeTreeRangeReader::startReadingChain(unsigned long, std::__1::deque<DB::MarkRange, std::__1::allocator<DB::MarkRange> >&) MergeTreeRangeReader.cpp:786
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





```c++
#0  DB::ReadBufferFromS3::seek (this=0x7f51c2685300, offset_=0, whence=0) at ../src/IO/ReadBufferFromS3.cpp:108
#1  0x000000002c2ee2f3 in DB::(anonymous namespace)::ReadIndirectBufferFromS3::initialize (this=0x7f51b3248900) at ../src/Disks/S3/DiskS3.cpp:234
#2  0x000000002c2edbce in DB::(anonymous namespace)::ReadIndirectBufferFromS3::nextImpl (this=0x7f51b3248900) at ../src/Disks/S3/DiskS3.cpp:246
#3  0x00000000223867cb in DB::ReadBuffer::next (this=0x7f51b3248900) at ../src/IO/ReadBuffer.h:59
#4  0x000000002c309710 in DB::SeekAvoidingReadBuffer::nextImpl (this=0x7f51a603fcc0) at ../src/IO/SeekAvoidingReadBuffer.cpp:61
#5  0x00000000223867cb in DB::ReadBuffer::next (this=0x7f51a603fcc0) at ../src/IO/ReadBuffer.h:59
#6  0x000000002c0f8dcb in DB::ReadBuffer::eof (this=0x7f51a603fcc0) at ../src/IO/ReadBuffer.h:87
#7  DB::CompressedReadBufferBase::readCompressedData (this=0x7f51a601e348, size_decompressed=@0x7f5176bbf708: 0, 
    size_compressed_without_checksum=@0x7f5176bbf700: 139987861108512) at ../src/Compression/CompressedReadBufferBase.cpp:95
#8  0x000000002cc6a1b6 in DB::CompressedReadBufferFromFile::nextImpl (this=0x7f51a601e2e0)
    at ../src/Compression/CompressedReadBufferFromFile.cpp:22
#9  0x000000002cc6a71d in DB::CompressedReadBufferFromFile::seek (this=0x7f51a601e2e0, offset_in_compressed_file=0, 
    offset_in_decompressed_block=0) at ../src/Compression/CompressedReadBufferFromFile.cpp:74
#10 0x000000002d4f1978 in DB::MergeTreeReaderStream::seekToStart (this=0x7f51a601e200) at ../src/Storages/MergeTree/MergeTreeReaderStream.cpp:150
#11 0x000000002d4f6c59 in DB::MergeTreeReaderWide::readData(std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > const&, DB::IDataType const&, DB::IColumn&, unsigned long, bool, unsigned long, bool)::$_1::operator()(bool) const::{lambda(std::__1::vector<DB::IDataType::Substream, std::__1::allocator<DB::IDataType::Substream> > const&)#1}::operator()(std::__1::vector<DB::IDataType::Substream, std::__1::allocator<DB::IDataType::Substream> > const&) const (this=0x7f51c2613108, substream_path=...)
    at ../src/Storages/MergeTree/MergeTreeReaderWide.cpp:243
#12 0x000000002d4f6ad2 in std::__1::__invoke<DB::MergeTreeReaderWide::readData(std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > const&, DB::IDataType const&, DB::IColumn&, unsigned long, bool, unsigned long, bool)::$_1::operator()(bool) const::{lambda(std::__1::vector<DB::IDataType::Substream, std::__1::allocator<DB::IDataType::Substream> > const&)#1}&, std::__1::vector<DB::IDataType::Substream, std::__1::allocator<DB::IDataType::Substream> > const&> (__f=..., __args=...) at ../contrib/libcxx/include/type_traits:3519
#13 0x000000002d4f6a72 in std::__1::__invoke_void_return_wrapper<DB::ReadBuffer*>::__call<DB::MergeTreeReaderWide::readData(std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > const&, DB::IDataType const&, DB::IColumn&, unsigned long, bool, unsigned long, bool)::$_1::operator()(bool) const::{lambda(std::__1::vector<DB::IDataType::Substream, std::__1::allocator<DB::IDataType::Substream> > const&)#1}&, std::__1::vector<DB::IDataType::Substream, std::__1::allocator<DB::IDataType::Substream> > const&>(DB::MergeTreeReaderWide::readData(std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > const&, DB::IDataType const&, DB::IColumn&, unsigned long, bool, unsigned long, bool)::$_1::operator()(bool) const::{lambda(std::__1::vector<DB::IDataType::Substream, std::__1::allocator<DB::IDataType::Substream> > const&)#1}&, std::__1::vector<DB::IDataType::Substream, std::__1::allocator<DB::IDataType::Substream> > const&) (__args=..., __args=...)
    at ../contrib/libcxx/include/__functional_base:317
```





```c++
#0  DB::S3::PocoHTTPClient::MakeRequestInternal (this=0x7f51bd43d020, request=..., response=...) at ../src/IO/S3/PocoHTTPClient.cpp:109
#1  0x000000002bbf82f9 in DB::S3::PocoHTTPClient::MakeRequest (this=0x7f51bd43d020, request=..., readLimiter=0x0, writeLimiter=0x0)
    at ../src/IO/S3/PocoHTTPClient.cpp:99
#2  0x000000002e28034c in Aws::Client::AWSClient::AttemptOneRequest(std::__1::shared_ptr<Aws::Http::HttpRequest> const&, Aws::AmazonWebServiceRequest const&, char const*, char const*) const ()
#3  0x000000002e27f1c1 in Aws::Client::AWSClient::AttemptExhaustively(Aws::Http::URI const&, Aws::AmazonWebServiceRequest const&, Aws::Http::HttpMethod, char const*, char const*) const ()
#4  0x000000002e281c94 in Aws::Client::AWSClient::MakeRequestWithUnparsedResponse(Aws::Http::URI const&, Aws::AmazonWebServiceRequest const&, Aws::Http::HttpMethod, char const*, char const*) const ()
#5  0x000000002e33ce0a in Aws::S3::S3Client::GetObject(Aws::S3::Model::GetObjectRequest const&) const ()
#6  0x000000002c2fac32 in DB::ReadBufferFromS3::initialize (this=0x7f51b2a2b600) at ../src/IO/ReadBufferFromS3.cpp:148
#7  0x000000002c2f88f0 in DB::ReadBufferFromS3::nextImpl (this=0x7f51b2a2b600) at ../src/IO/ReadBufferFromS3.cpp:81
#8  0x00000000223867cb in DB::ReadBuffer::next (this=0x7f51b2a2b600) at ../src/IO/ReadBuffer.h:59
#9  0x000000002c2edc2a in DB::(anonymous namespace)::ReadIndirectBufferFromS3::nextImpl (this=0x7f51a8435000) at ../src/Disks/S3/DiskS3.cpp:249
#10 0x00000000223867cb in DB::ReadBuffer::next (this=0x7f51a8435000) at ../src/IO/ReadBuffer.h:59
#11 0x000000002c309710 in DB::SeekAvoidingReadBuffer::nextImpl (this=0x7f51a84229c0) at ../src/IO/SeekAvoidingReadBuffer.cpp:61
#12 0x00000000223867cb in DB::ReadBuffer::next (this=0x7f51a84229c0) at ../src/IO/ReadBuffer.h:59
#13 0x000000002c0f8dcb in DB::ReadBuffer::eof (this=0x7f51a84229c0) at ../src/IO/ReadBuffer.h:87
#14 DB::CompressedReadBufferBase::readCompressedData (this=0x7f51a8418848, size_decompressed=@0x7f51822d5658: 0, 
    size_compressed_without_checksum=@0x7f51822d5650: 139988053087856) at ../src/Compression/CompressedReadBufferBase.cpp:95
#15 0x000000002cc6a1b6 in DB::CompressedReadBufferFromFile::nextImpl (this=0x7f51a84187e0)
    at ../src/Compression/CompressedReadBufferFromFile.cpp:22
#16 0x000000002cc6a71d in DB::CompressedReadBufferFromFile::seek (this=0x7f51a84187e0, offset_in_compressed_file=0, 
    offset_in_decompressed_block=0) at ../src/Compression/CompressedReadBufferFromFile.cpp:74
#17 0x000000002d4f16dc in DB::MergeTreeReaderStream::seekToMark (this=0x7f51a8418700, index=0)
    at ../src/Storages/MergeTree/MergeTreeReaderStream.cpp:127
#18 0x000000002d4f6c93 in DB::MergeTreeReaderWide::readData
```







```c++
class ReadBufferFromS3 : public SeekableReadBuffer
class SeekableReadBuffer : public ReadBuffer
  
  
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

	
new and seek
#0  DB::ReadBufferFromS3::seek (this=0x7f51c2685300, offset_=0, whence=0) at ../src/IO/ReadBufferFromS3.cpp:108
#1  0x000000002c2ee2f3 in DB::(anonymous namespace)::ReadIndirectBufferFromS3::initialize (this=0x7f51b3248900) at ../src/Disks/S3/DiskS3.cpp:234
#2  0x000000002c2edbce in DB::(anonymous namespace)::ReadIndirectBufferFromS3::nextImpl (this=0x7f51b3248900) at ../src/Disks/S3/DiskS3.cpp:246
```

