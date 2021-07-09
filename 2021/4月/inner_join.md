```sql
CREATE TABLE download (
  when DateTime,
  userid UInt32,
  bytes UInt64
) ENGINE=MergeTree
PARTITION BY toYYYYMM(when)
ORDER BY (userid, when)


CREATE TABLE price (
  userid UInt32,
  price_per_gb Float64
) ENGINE=MergeTree
PARTITION BY tuple()
ORDER BY userid


CREATE TABLE download_daily2 (
  day Date,
  userid UInt32,
  downloads UInt32,
  total_gb Float64,
  total_price Float64
)
ENGINE = SummingMergeTree
PARTITION BY toYYYYMM(day) ORDER BY (userid, day)


CREATE MATERIALIZED VIEW download_daily_mv2
TO download_daily2 AS
SELECT
  
  day AS day, userid AS userid, count() AS downloads,
  sum(gb) as total_gb, sum(price) as total_price
FROM (
  SELECT
    toDate(A.when) AS day,
    B.userid AS userid,
    A.bytes / (1024*1024*1024) AS gb,
    gb * B.price_per_gb AS price
  FROM download as A inner JOIN price as B ON A.userid = B.userid
)
GROUP BY userid, day





CREATE table LEFT_TABLE2 (
  day Date,
  id UInt32,
  number UInt32
) ENGINE=MergeTree
PARTITION BY toYYYYMM(day)
ORDER BY id;


CREATE table RIGHT_TABLE2 (
  id UInt32,
  number UInt32
) ENGINE=MergeTree
PARTITION BY tuple()
ORDER BY id;


CREATE TABLE meterialized_table_storage (
  day Date,
  id UInt32,
  number UInt32
)
ENGINE =MergeTree
PARTITION BY toYYYYMM(day) ORDER BY (id);



CREATE MATERIALIZED VIEW meterialized_table_1
TO meterialized_table_1_storage AS
select 
day,
LEFT_TABLE.id,
RIGHT_TABLE.number
from LEFT_TABLE 
INNER JOIN RIGHT_TABLE  ON LEFT_TABLE.id = RIGHT_TABLE.id;







CREATE table RIGHT_TABLE2 (
  id2 UInt32,
  number UInt32
) ENGINE=MergeTree
PARTITION BY tuple()
ORDER BY id2;



CREATE TABLE meterialized_table2_storage (
  day Date,
  id UInt32,
  number UInt32
)
ENGINE =MergeTree
PARTITION BY toYYYYMM(day) ORDER BY (id);



CREATE MATERIALIZED VIEW meterialized_table_2
TO meterialized_table_2_storage AS
select 
A.day,
A.id,
RIGHT_TABLE2.number
from LEFT_TABLE as A
INNER JOIN RIGHT_TABLE2 ON A.id = RIGHT_TABLE.id2;
```







https://altinity.com/blog/2020-07-14-joins-in-clickhouse-materialized-views



https://altinity.com/blog/clickhouse-materialized-views-illuminated-part-1



https://blog.csdn.net/Wen__Fei/article/details/108076957



https://github.com/ClickHouse/ClickHouse/issues/10894



https://github.com/ClickHouse/ClickHouse/issues/11000



https://blog.csdn.net/whiteBearClimb/article/details/111284176?utm_medium=distribute.pc_relevant.none-task-blog-baidujs_baidulandingword-0&spm=1001.2101.3001.4242





```
DB::CollectJoinOnKeysMatcher::Data::addJoinKeys(std::__1::shared_ptr<DB::IAST> const&, std::__1::shared_ptr<DB::IAST> const&, std::__1::pair<unsigned long, unsigned long> const&) CollectJoinOnKeysVisitor.cpp:22
DB::CollectJoinOnKeysMatcher::visit(DB::ASTFunction const&, std::__1::shared_ptr<DB::IAST> const&, DB::CollectJoinOnKeysMatcher::Data&) CollectJoinOnKeysVisitor.cpp:82
DB::CollectJoinOnKeysMatcher::visit(std::__1::shared_ptr<DB::IAST> const&, DB::CollectJoinOnKeysMatcher::Data&) CollectJoinOnKeysVisitor.h:46
DB::InDepthNodeVisitor<DB::CollectJoinOnKeysMatcher, true, std::__1::shared_ptr<DB::IAST> const>::visit(std::__1::shared_ptr<DB::IAST> const&) InDepthNodeVisitor.h:34
DB::(anonymous namespace)::collectJoinedColumns(DB::TableJoin&, DB::ASTSelectQuery const&, std::__1::vector<DB::TableWithColumnNamesAndTypes, std::__1::allocator<DB::TableWithColumnNamesAndTypes> > const&, std::__1::unordered_map<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >, std::__1::shared_ptr<DB::IAST>, std::__1::hash<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > >, std::__1::equal_to<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > >, std::__1::allocator<std::__1::pair<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > const, std::__1::shared_ptr<DB::IAST> > > > const&) TreeRewriter.cpp:540
DB::TreeRewriter::analyzeSelect(std::__1::shared_ptr<DB::IAST>&, DB::TreeRewriterResult&&, DB::SelectQueryOptions const&, std::__1::vector<DB::TableWithColumnNamesAndTypes, std::__1::allocator<DB::TableWithColumnNamesAndTypes> > const&, std::__1::vector<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >, std::__1::allocator<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > > > const&, std::__1::shared_ptr<DB::TableJoin>) const TreeRewriter.cpp:934
DB::InterpreterSelectQuery::InterpreterSelectQuery(std::__1::shared_ptr<DB::IAST> const&, std::__1::shared_ptr<DB::Context>, std::__1::shared_ptr<DB::IBlockInputStream> const&, std::__1::optional<DB::Pipe>, std::__1::shared_ptr<DB::IStorage> const&, DB::SelectQueryOptions const&, std::__1::vector<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >, std::__1::allocator<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > > > const&, std::__1::shared_ptr<DB::StorageInMemoryMetadata const> const&)::$_2::operator()(bool) const InterpreterSelectQuery.cpp:378
DB::InterpreterSelectQuery::InterpreterSelectQuery(std::__1::shared_ptr<DB::IAST> const&, std::__1::shared_ptr<DB::Context>, std::__1::shared_ptr<DB::IBlockInputStream> const&, std::__1::optional<DB::Pipe>, std::__1::shared_ptr<DB::IStorage> const&, DB::SelectQueryOptions const&, std::__1::vector<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >, std::__1::allocator<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > > > const&, std::__1::shared_ptr<DB::StorageInMemoryMetadata const> const&) InterpreterSelectQuery.cpp:483
DB::InterpreterSelectQuery::InterpreterSelectQuery(std::__1::shared_ptr<DB::IAST> const&, std::__1::shared_ptr<DB::Context>, std::__1::shared_ptr<DB::IBlockInputStream> const&, std::__1::optional<DB::Pipe>, std::__1::shared_ptr<DB::IStorage> const&, DB::SelectQueryOptions const&, std::__1::vector<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >, std::__1::allocator<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > > > const&, std::__1::shared_ptr<DB::StorageInMemoryMetadata const> const&) InterpreterSelectQuery.cpp:281
DB::InterpreterSelectQuery::InterpreterSelectQuery(std::__1::shared_ptr<DB::IAST> const&, std::__1::shared_ptr<DB::Context>, DB::SelectQueryOptions const&, std::__1::vector<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >, std::__1::allocator<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > > > const&) InterpreterSelectQuery.cpp:159
std::__1::__unique_if<DB::InterpreterSelectQuery>::__unique_single std::__1::make_unique<DB::InterpreterSelectQuery, std::__1::shared_ptr<DB::IAST> const&, std::__1::shared_ptr<DB::Context>&, DB::SelectQueryOptions&, std::__1::vector<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >, std::__1::allocator<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > > > const&>(std::__1::shared_ptr<DB::IAST> const&, std::__1::shared_ptr<DB::Context>&, DB::SelectQueryOptions&, std::__1::vector<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >, std::__1::allocator<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > > > const&) memory:2068
DB::InterpreterSelectWithUnionQuery::buildCurrentChildInterpreter(std::__1::shared_ptr<DB::IAST> const&, std::__1::vector<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >, std::__1::allocator<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > > > const&) InterpreterSelectWithUnionQuery.cpp:212
DB::InterpreterSelectWithUnionQuery::InterpreterSelectWithUnionQuery(std::__1::shared_ptr<DB::IAST> const&, std::__1::shared_ptr<DB::Context>, DB::SelectQueryOptions const&, std::__1::vector<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >, std::__1::allocator<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > > > const&) InterpreterSelectWithUnionQuery.cpp:134
DB::InterpreterSelectWithUnionQuery::InterpreterSelectWithUnionQuery(std::__1::shared_ptr<DB::IAST> const&, std::__1::shared_ptr<DB::Context>, DB::SelectQueryOptions const&, std::__1::vector<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >, std::__1::allocator<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > > > const&) InterpreterSelectWithUnionQuery.cpp:34
DB::InterpreterSelectWithUnionQuery::getSampleBlock(std::__1::shared_ptr<DB::IAST> const&, std::__1::shared_ptr<DB::Context>, bool) InterpreterSelectWithUnionQuery.cpp:231
DB::InterpreterCreateQuery::setProperties(DB::ASTCreateQuery&) const InterpreterCreateQuery.cpp:544
DB::InterpreterCreateQuery::createTable(DB::ASTCreateQuery&) InterpreterCreateQuery.cpp:901
DB::InterpreterCreateQuery::execute() InterpreterCreateQuery.cpp:1241
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

