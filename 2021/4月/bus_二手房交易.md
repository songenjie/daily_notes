1、意向购房；
2、看房，选中一套，找中介拉上业主一起谈价位；
3、双方谈好价位，签三方购买合同（自己、业主、中介），同时谈好中介费用问题（最好在合同中体现）
4、按照约定时间去二手房交易公司进行网签面签，若此时自己资金富裕，则可以进行刷首付；
5、等待审核资料通过，若业主还有尾款未还，则通过之后，业主预约银行还尾款，尾款还完预估一周内可以撤押完成，撤押完成将资料给权证服务人员；
6、权证服务人员拿到业主撤押完成资料后，递交给自己贷款银行，等着放贷；
7、放贷完成之后，业主、自己、中介去二手房交易市场做缴税过户；
8、过户完，去小区物业那里做“交接”，收房！







std::__1::optional<unsigned long> DB::(anonymous namespace)::tryChooseTable<DB::TableWithColumnNamesAndTypes>(DB::ASTIdentifier const&, std::__1::vector<DB::TableWithColumnNamesAndTypes, std::__1::allocator<DB::TableWithColumnNamesAndTypes> > const&, bool, bool) IdentifierSemantic.cpp:62
DB::IdentifierSemantic::chooseTable(DB::ASTIdentifier const&, std::__1::vector<DB::TableWithColumnNamesAndTypes, std::__1::allocator<DB::TableWithColumnNamesAndTypes> > const&, bool) IdentifierSemantic.cpp:140

DB::TranslateQualifiedNamesMatcher::visit(DB::ASTIdentifier&, std::__1::shared_ptr<DB::IAST>&, DB::TranslateQualifiedNamesMatcher::Data&) 0x0000000113224977
DB::TranslateQualifiedNamesMatcher::visit(std::__1::shared_ptr<DB::IAST>&, DB::TranslateQualifiedNamesMatcher::Data&) 0x00000001132247e1
DB::InDepthNodeVisitor<DB::TranslateQualifiedNamesMatcher, true, std::__1::shared_ptr<DB::IAST> >::visit(std::__1::shared_ptr<DB::IAST>&) InDepthNodeVisitor.h:34
DB::InDepthNodeVisitor<DB::TranslateQualifiedNamesMatcher, true, std::__1::shared_ptr<DB::IAST> >::visitChildren(std::__1::shared_ptr<DB::IAST>&) InDepthNodeVisitor.h:55
DB::InDepthNodeVisitor<DB::TranslateQualifiedNamesMatcher, true, std::__1::shared_ptr<DB::IAST> >::visit(std::__1::shared_ptr<DB::IAST>&) InDepthNodeVisitor.h:43
DB::InDepthNodeVisitor<DB::TranslateQualifiedNamesMatcher, true, std::__1::shared_ptr<DB::IAST> >::visitChildren(std::__1::shared_ptr<DB::IAST>&) InDepthNodeVisitor.h:55
DB::InDepthNodeVisitor<DB::TranslateQualifiedNamesMatcher, true, std::__1::shared_ptr<DB::IAST> >::visit(std::__1::shared_ptr<DB::IAST>&) InDepthNodeVisitor.h:43
DB::(anonymous namespace)::translateQualifiedNames(std::__1::shared_ptr<DB::IAST>&, DB::ASTSelectQuery const&, std::__1::unordered_set<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >, std::__1::hash<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > >, std::__1::equal_to<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > >, std::__1::allocator<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > > > const&, std::__1::vector<DB::TableWithColumnNamesAndTypes, std::__1::allocator<DB::TableWithColumnNamesAndTypes> > const&) TreeRewriter.cpp:261
DB::TreeRewriter::analyzeSelect(std::__1::shared_ptr<DB::IAST>&, DB::TreeRewriterResult&&, DB::SelectQueryOptions const&, std::__1::vector<DB::TableWithColumnNamesAndTypes, std::__1::allocator<DB::TableWithColumnNamesAndTypes> > const&, std::__1::vector<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >, std::__1::allocator<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > > > const&, std::__1::shared_ptr<DB::TableJoin>) const TreeRewriter.cpp:903
DB::InterpreterSelectQuery::InterpreterSelectQuery(std::__1::shared_ptr<DB::IAST> const&, std::__1::shared_ptr<DB::Context>, std::__1::shared_ptr<DB::IBlockInputStream> const&, std::__1::optional<DB::Pipe>, std::__1::shared_ptr<DB::IStorage> const&, DB::SelectQueryOptions const&, std::__1::vector<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >, std::__1::allocator<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > > > const&, std::__1::shared_ptr<DB::StorageInMemoryMetadata const> const&)::$_2::operator()(bool) const InterpreterSelectQuery.cpp:378
DB::InterpreterSelectQuery::InterpreterSelectQuery(std::__1::shared_ptr<DB::IAST> const&, std::__1::shared_ptr<DB::Context>, std::__1::shared_ptr<DB::IBlockInputStream> const&, std::__1::optional<DB::Pipe>, std::__1::shared_ptr<DB::IStorage> const&, DB::SelectQueryOptions const&, std::__1::vector<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >, std::__1::allocator<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > > > const&, std::__1::shared_ptr<DB::StorageInMemoryMetadata const> const&) InterpreterSelectQuery.cpp:483
DB::InterpreterSelectQuery::InterpreterSelectQuery(std::__1::shared_ptr<DB::IAST> const&, std::__1::shared_ptr<DB::Context>, std::__1::shared_ptr<DB::IBlockInputStream> const&, std::__1::optional<DB::Pipe>, std::__1::shared_ptr<DB::IStorage> const&, DB::SelectQueryOptions const&, std::__1::vector<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >, std::__1::allocator<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > > > const&, std::__1::shared_ptr<DB::StorageInMemoryMetadata const> const&) InterpreterSelectQuery.cpp:281
DB::InterpreterSelectQuery::InterpreterSelectQuery(std::__1::shared_ptr<DB::IAST> const&, std::__1::shared_ptr<DB::Context>, DB::SelectQueryOptions const&, std::__1::vector<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >, std::__1::allocator<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > > > const&) InterpreterSelectQuery.cpp:159
std::__1::__unique_if<DB::InterpreterSelectQuery>::__unique_single std::__1::make_unique<DB::InterpreterSelectQuery, std::__1::shared_ptr<DB::IAST> const&, std::__1::shared_ptr<DB::Context>&, DB::SelectQueryOptions&, std::__1::vector<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >, std::__1::allocator<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > > > const&>(std::__1::shared_ptr<DB::IAST> const&, std::__1::shared_ptr<DB::Context>&, DB::SelectQueryOptions&, std::__1::vector<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >, std::__1::allocator<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > > > const&) memory:2068
DB::InterpreterSelectWithUnionQuery::buildCurrentChildInterpreter(std::__1::shared_ptr<DB::IAST> const&, std::__1::vector<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >, std::__1::allocator<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > > > const&) InterpreterSelectWithUnionQuery.cpp:212
DB::InterpreterSelectWithUnionQuery::InterpreterSelectWithUnionQuery(std::__1::shared_ptr<DB::IAST> const&, std::__1::shared_ptr<DB::Context>, DB::SelectQueryOptions const&, std::__1::vector<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >, std::__1::allocator<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > > > const&) InterpreterSelectWithUnionQuery.cpp:134
DB::InterpreterSelectWithUnionQuery::InterpreterSelectWithUnionQuery(std::__1::shared_ptr<DB::IAST> const&, std::__1::shared_ptr<DB::Context>, DB::SelectQueryOptions const&, std::__1::vector<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >, std::__1::allocator<std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > > > const&) InterpreterSelectWithUnionQuery.cpp:34
DB::InterpreterSelectWithUnionQuery::getSampleBlock(std::__1::shared_ptr<DB::IAST> const&, std::__1::shared_ptr<DB::Context>, bool) InterpreterSelectWithUnionQuery.cpp:231
DB::InterpreterCreateQuery::setProperties(DB::ASTCreateQuery&) const 0x0000000112f3d789
DB::InterpreterCreateQuery::createTable(DB::ASTCreateQuery&) 0x0000000112f43150
DB::InterpreterCreateQuery::execute() 0x0000000112f47bf6
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


