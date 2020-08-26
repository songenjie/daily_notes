### **ClickHouse 内部架构介绍**



ClickHouse是一个完全面向列式的分布式数据库。数据通过列存储，在查询过程中，数据通过数组来处理(向量或者列Chunk)。当进行查询时，操作被转发到数组上，而不是在特定的值上。因此被称为”向量化查询执行”，相对于实际的数据处理成本，向量化处理具有更低的转发成本。

这个设计思路并不是新的思路理念。历史可以追溯到`APL`编程语言时代：`A+`, `J`, `K`, and `Q`。数组编程广泛用于科学数据处理领域。而在关系型数据库中：也应用了`向量化`系统。

在加速查询处理上，有两种的方法：向量化查询执行和运行时代码生成。为每种查询类型都进行代码生成，去除所有的间接和动态转发处理。这些方法并不比其他方法好，当多个操作一起执行时，运行时代码生成会更好，可以充分累用CPU执行单元和Pipeline管道。

向量化查询执行实用性并不那么高，因为它涉及到临时向量，必须写到缓存中，并读取回来。如果临时数据并不适合L2缓存，它可能是一个问题。但是向量化查询执行更容易利用CPU的SIMD能力。一个研究论文显示将两个方法结合到一起效果会更好。ClickHouse主要使用向量化查询执行和有限的运行时代码生成支持(仅GROUP BY内部循环第一阶段被编译)。

列

------

为了表示内存中的列(列的 chunks)，`IColumn`将被使用。这个接口提供了一些辅助方法来实现不同的关系操作符。几乎所有的操作符都是非更改的：他们不能更改原有的列，但是创建一个新的更新的列。例如，IColumn::filter方法接受一个过滤器字节掩码，同时创建一个新的过滤列。它被用在WHERE和HAVING的关系操作符上。额外的示例：IColumn::permute方法支持ORDER BY，IColumn::cut方法支持LIMIT等。

不同的IColumn实现(ColumnUInt8,ColumnString等)负责列的内存布局。内存布局通常是一个连续的数组。对于列的整型来说，它是一个连续的数组，如std::vector。对于String和Array列,这个是2个vectors:一个是所有的数组元素,连续放置,另一个是偏移量(offsets),位于每个数组的起始端。也有ColumnConst用于在内存中存储一个值,但是它看起来像一个列。

数据域

------

然而, 它也可能工作在单独的值上面。为了表示一个单独的值。数据域使用.Fieldis 这是一个UInt64,Int64,Float64,StringandArray可区分的集合。IColumn 有operator[]方法来获得n-th值作为一个数据域，insert[] 方法追加一个数据域到一个列的末尾。这些方法不是特别高效，因为他们需要处理临时的数据域对象，它代表一个单独的值。这是一个最高效的方法,例如insertFrom, insertRangeFrom等。

对于一个表，一个特定的数据类型，数据域没有足够的信息。例如 ,UInt8,UInt16,UInt32, 和 UInt64都用 UInt64表示。

抽象渗漏法则

------

IColumn有方法用于通用的关系型数据转换，但是它并不能满足所有需求。例如，ColumnUInt64没有方法来计算2个列的加和，ColumnString没有方法用于运行子字符串的搜索。一些进程是在IColumn之外实现的。

列中的不同函数能够以一个通用的方式来实现，使用IColumn方法来抽取数据域值，或者在特定的方法下使用数据的内部内存布局在特定的IColumn上实现。为了完成这个，函数将被转换成一个特定的IColumn类型，直接在内部进行处理。例如，ColumnUInt64有一个getData方法，将返回一个内存数组的引用，然后一个单独的进程读取或者直接填充这个数组。事实上，我们有一个抽象渗漏法则来允许不同进程的专用化。

数据类型

------

IDataType 负责序列化和反序列化: 读写这个列的值或者以二进制或文本的方式的值.IDataType 直接与表中的数据类型一致。例如，有DataTypeUInt32,DataTypeDateTime,DataTypeString等。

IDataType和IColumnare 互相是松耦合的。不同的数据类型能够在内存中表示，通过相同的IColumn 实现.。例如,DataTypeUInt32和DataTypeDateTime都是通过ColumnUInt32或者ColumnConstUInt32来表示。另外，相同的数据类型通过不同的IColumn实现来表示. 例如,DataTypeUInt8 能够通过ColumnUInt8或者ColumnConstUInt8.来表示。

IDataType 仅存储元数据。例如，DataTypeUInt8 根本不保存任何数据 (除了 vptr) ，同时DataTypeFixedString 保存justN(确定的字符串大小)。

IDataType 对于不同的数据格式都有协助方法。示例是有些方法可以序列化一个值, 序列化一个值到 JSON，序列化一个值到 XML 格式。没有直接的数据格式一一对应。例如，不同的数据格式Pretty和TabSeparated 能够使用相同的serializeTextEscaped协助方法，在IDataType接口中。

数据块

------

一个数据块是一个容器，代表了内存中一个表的子集。它也是三元组的集合:(IColumn,IDataType,columnname). 在查询执行过程中, 数据通过数据块来处理. 如果你有一个数据块， 我们有数据(在IColumn对象中), 我们有这个数据的类型(在IDataType中) 告诉我们怎样处理此列，同时我们有此列名称 (或者是原有列名, 或者是人工命名，得到计算的临时结果)。

在一个数据块中，当我们计算跨列某个函数时, 我们添加另外的带有结果的列到数据块中, 我们并不修改这个列，因为这些操作都是非变更的。然后，不需要的列将从数据块中删除，但不是修改。这个对于消除子表达式是便捷的。

数据块为了每个处理的数据 Chunk 创建的。 对于相同的计算类型，列名称和类型对于不同的数据块将保持一致, 只有列数据保持变化。这样有利于更好地从数据块头拆分数据，因为小的数据块大小将有高的临时字符串开销，当拷贝 shared_ptrs 和 column names时。

数据块流

------

数据块流用于处理数据。我们使用数据块的数据流从某处读取数据，执行数据转换或者写入数据到某处。IBlockInputStream 有一个read方法获取下一个数据块。IBlockOutputStream 有一个write方法发送数据块到某处。

数据流负责：

读写一个表。当读写数据块时，此表将返回一个数据流。

实现数据格式。例如，如果你想要输出数据以Pretty的格式到一个终端时。你将创建一个数据块输出流，然后格式化这个数据块。

执行数据转换。你有BlockInputStream 同时 想要创建一个过滤数据流。你创建FilterBlockInputStream，初始化它。然后当你从 FilterBlockInputStream拉取一个数据块时，它将从数据流中获得到一个数据块，，过滤它，然后返回已经过滤的数据块给你。查询执行的 Pipeline 将展示这个方式。

有一些更加综合的转换。例如，当你从AggregatingBlockInputStream拉取数据时，它将从数据源上读取所有的数据，聚合它，然后为你返回一个汇总数据流。另一个示例：UnionBlockInputStream接收很多输入数据源和一些线程。它启动了多个线程，从多个数据源中并行读取数据。

数据块流使用“pull” 的方式来控制数据流：当你从第一个数据流中拉取一个数据块时，它从嵌套的数据流中拉取所需要的数据块，整个执行 pipeline 将正常工作。其实“pull” 和 “push”都不是最佳方案，因为流控是隐式的，限制了不同特性的实现，如多个查询的并行执行(一起合并多个 pipeline)。此限制是协程或者运行互相等待的外部线程。我们也能够更多的可能性，如果我们进行显式的流控：如果我们定位这个逻辑，从一个计算单元传递数据到外部的一个计算单元。更多的想法，参考此文章。

查询执行流水线将在每个步骤创建临时数据。我们将保持数据块大小要足够小，因此临时数据要适合CPU缓存。假设，读写临时数据几乎是自由的，相对于其他计算来说。我们可以考虑一个替代方案，融合多个操作在 pipeline 中，让 pipeline 尽可能小，删除尽可能多的临时数据。这个可以是一个优势，也可能是个劣势。例如，一个拆分 pipeline 将容易实现缓存中间数据，从类似的查询中偷取中间数据，然后对于类似查询，合并 pipeline。

格式

------

数据格式用数据块流来实现。有种“显示性”格式仅适用于数据输出到客户端，例如 Pretty 格式, 它仅提供 IBlockOutputStream。有输入输出格式，例如 TabSeparated 或JSONEachRow。

也有行数据流: IRowInputStream和 IRowOutputStream. 他们允许你按照行来推/拉数据, 而不是通过数据块. 他们仅被用于简化面向行格式的实现。封装器BlockInputStreamFromRowInputStream 和BlockOutputStreamFromRowOutputStream 允许你转换面向行的数据流到面向数据块的数据流。

I/O

------

对于面向字节的输入/输出。有 ReadBuffer 和 WriteBuffer 抽象类. 他们被用于替代C++ iostream。 不用担心：每个成熟的 C++ 工程都用更优的类库.

ReadBuffer 和 WriteBuffer 是一个连续的Buffer，游标指向Buffer的位置. 具体实现可能有或没有内存。有个虚方法来用如下数据填充Buffer填充。 (对于ReadBuffer) 或者刷新Buffer到某处 (对于 WriteBuffer). 虚方法很少被调用。

Implementations of ReadBuffer/WriteBuffer 的实现被用于文件，文件描述和网络套接字的处理，如实现压缩 (CompressedWriteBuffer 用另外的 WriteBuffer 来初始化，在写数据之前执行压缩），或者用于其他目的  – 名称ConcatReadBuffer, LimitReadBuffer, 和HashingWriteBuffer 等。

Read/WriteBuffers 仅用于处理字节，带有格式化的输入/输出 (例如, 以decimal的方式写入一个数字), 有一些函数是来自ReadHelpers 和WriteHelpers 头文件的。

让我们看一下当你想以Json的格式写入结果集到标准输出时发生了什么。你有一个结果集准备从IBlockInputStream获取。你创建了 WriteBufferFromFileDescriptor(STDOUT_FILENO) 写入字节到标准输出. 你创建JSONRowOutputStream, 用 WriteBuffer来初始化, 写入行到标准输出。你在行输出流之上创建 数据块输出流BlockOutputStreamFromRowOutputStream, 用IBlockOutputStream显示它. 然后调用 copyData从IBlockInputStream 到 IBlockOutputStream来传输数据. 从内部来看, JSONRowOutputStream 将写入不同的 JSON分隔符，调用 IDataType::serializeTextJSON 方法 引用到IColumn ，同时行数作为参数。然后，IDataType::serializeTextJSON将从 WriteHelpers.h调用一个方法：例如, 对于数字类型用writeText， 对于字符串类型用writeJSONString。

表

------

表通过IStorage接口来表示.对此接口不同的实现成为不同的表引擎. 例如 StorageMergeTree, StorageMemory, 等，这些类的实例是表。

最重要的IStorage 方法是读和写操作. 也有alter, rename, drop, 等操作. 读方法接受如下的参数：从表中读取的列集合,  AST 查询, 返回需要的数据流的数量. 它返回一个或多个 IBlockInputStream 对象和有关数据处理阶段的信息，在查询的过程中在表引擎中完成。

在大多数情况下，read方法负责从表中读取特定的列，不进行后续的7数据处理。所有的进一步数据处理通过查询中断器来完成，这个在IStorage处理范围之外。

但是也有一些例外： - AST 查询被传递到read方法，表引擎使用它来衍生对索引的使用， 同时从一个表中读取少量数据. - 有时表引擎能够处理数据到一个特定的阶段。例如, StorageDistributed 能够发送一个查询到远程服务器，让他们处理数据到一个阶段，即来自不同远程服务器的数据能够被合并，同时返回预处理后数据 查询中断器随即结束对数据的处理。

表的read方法能够返回多个IBlockInputStream 对象允许并行处理数据. 这些多个数据块输入流能够从一个表中并行读取数据. 然后你能够用不同的转换来封装这些数据流(例如表达式评估，数据过滤) 能够被单独计算，同时在它们之上创建一个UnionBlockInputStream, 从多个数据流中并行读取。

也有一些TableFunction. 有一些函数返回临时的``IStorage 对象，用在查询的 FROM 语句中.

为了快速建立一个印象，怎样实现你自己的表引擎，如StorageMemory或StorageTinyLog。

作为read方法的结果, IStorage 返回 QueryProcessingStage – 此信息将返回哪个查询部分已经在Storage中被计算. 当前，我们仅有非常粗粒度的信息。对于存储来说，没有方法说“我已经处理了Where条件中的表达式部分，对于此数据范围” 。我们需要工作在其上。

解析器

------

一个查询通过手写的递归解析器被解析。例如， ParserSelectQuery递归调用如下的解析，对于不同的查询部分。解析器创建了一个AST. 这个AST通过节点来表示，它是一个IAST实例。

由于历史原因，解析器生成并没有被使用。

中断器

------

中断器负责从一个AST上创建查询执行Pipeline。有一些简单的中断器，例如 InterpreterExistsQuery`和`InterpreterDropQuery, 或者更复杂一些的 InterpreterSelectQuery. 此查询执行pipeline是数据块输入个输出流的结合体。例如，中断SELECT 查询的结果是IBlockInputStream 读取结果集； INSERT 查询的结果是 IBlockOutputStream 为了插入而写入数据；and the result of interpreting the中断 INSERT SELECT 查询的结果是在第一次读取时，返回一个空结果集, 但是同时从SELECT到INSERT拷贝数据。

InterpreterSelectQuery 使用了ExpressionAnalyzer和ExpressionActions 机制来查询分析和转换。 这是一个基于规则的查询优。ExpressionAnalyzer 是有点乱的，应该被重写: 不同的查询转换和优化应该被提取到不同的类，来允许模块化的转化和查询。

函数

------

有一些普通函数和聚合函数。 对于聚合函数，请查看下一个章节。

普通函数并不能改变行的数量 – 他们单独处理每个行。事实上，对于每个行，函数不能被调用，但是对于数据块的数据可实现向量化查询执行。

有一些 混合函数, 例如blockSize, rowNumberInBlock, 和runningAccumulate, 拓展了数据块处理，违反了行的独立性。

ClickHouse 有强类型，因此隐式类型转换不能执行。如果函数不支持一个特定的类型绑定，异常将会抛出。但是函数能够工作在很多不同的类型关联。例如， plus 函数 (实现了 + 操作符) 能够工作在任意的数字类型关联：UInt8 + Float32, UInt16 + Int8, 等。一些变种函数能够接收任意数量的参数，如concat 函数。

聚合函数

------

聚合函数是状态函数。 他们积累传递的值到某个状态, 允许你从这个状态获得结果。他们用IAggregateFunction来管理。状态可以很简单 (对于 AggregateFunctionCount 的状态是一个单UInt64值) 或者相当复杂 (AggregateFunctionUniqCombined 的状态是与线性数组相关, 一个哈希表， 一个 HyperLogLog 概率性数据结构)。

为了处理多个状态，当执行一个高基数 GROUP BY 查询, 状态被分配在Arena中(一个内存池), 或者他们能够以任意合适的内存分片被分配. 状态可以有一个非细碎的构造器和析构器：例如， 复杂的聚合状态能够自己分配额外的内存，这块需要注意，对于创建和销毁状态，同时传递他们的所属关系，追踪是谁和什么时候将销毁这个状态。

聚合状态能够序列化和反序列化来跨网络传递，在执行分布式查询期间，或者如果没有足够的内存情况下，将他们写入到磁盘. 他们甚至能够存储到表内，DataTypeAggregateFunction 允许增量聚合数据。

对于聚合函数状态，序列化的数据格式目前不是版本化的。如果聚合状态仅是临时存储，那是没问题的。但是对于增量聚合，我们有AggregatingMergeTreetable 引擎，同时很多用户已经在生产环境中使用他们了。这就是为什么我们应该增加向后兼容的支持，未来当为任意的聚合函数更改序列化格式时。

服务器

------

服务器实现了不同的接口：

- 对于任意的外部客户端暴露一个HTTP接口
- 对于本地客户端暴露一个TCP 接口，在分布式查询执行时，用于跨服务器通信
- 一个接口用于传输同步数据

从内部来讲，这是一个基本的多线程服务器，没有携程, fibers, 等。服务器并没有为高频率短查询来设计，而是为了处理低频率的复杂查询， 这两种方式处理的数据量是不同的。

对于查询执行，服务器初始化上下文类，包括数据库列表，用户，访问权限，设置，集群，处理列表，查询日志，等。这个上下文环境被中断器使用。

对于服务器的TCP协议，我们维护了向前兼容和向后兼容：老客户端能访问新服务器，新客户端能访问老服务器。但是我们不想一直维护它们, 未来一年我们将停止对老版本的支持。

对于外部应用，我们推荐使用 HTTP 接口，因为它比较简单易用。TCP 协议与内部数据结构有很多关联耦合：它使用一个内部结构来传递数据块，使用自定义的帧来用于压缩。 对于此协议我们没有发布一个 C 的库，因为它需要连接大部分 ClickHouse 的代码库, 这么做不实际。

分布式查询执行

------

在一个集群设置中的服务器大部分是独立的。你能够在一个或所有的服务器上创建一个分布式表。此分布式表本身不存储数据—在集群的多个节点上，仅提供一个"视图"到所有的本地表。当你从分布式表进行查询时，它重写这个查询，根据负载均衡的设置，选择远程节点，发送查询给他们。

分布式表请求远程服务器来处理一个查询到一个阶段，此阶段从不同的服务器中继结果后进行合并。然后接收结果后合并这些结果。分布式表尝试分布尽可能多的工作到远程服务器，不能跨网络发送太多的中继数据。

当你进行 IN 或 JOIN 子查询时，情况变得更加复杂一些，每个子查询都使用一个分布式表。我们有不同的策略来执行这些查询。

对于分布式查询执行，没有一个全局的查询规划。每个节点有自己的本地查询规划作为任务的一部分。我们仅有一个简化的一步分布式查询执行：我们为远程节点发送查询，然后合并结果集。但是对于高基数的GROUP BY高难度查询是并不可行的，或者大量临时数据的 JOIN 查询。ClickHouse并不支持这种查询方式，我们需要进一步开发它。 合并树

------

合并树(MergeTree)是存储引擎的族，通过主键来支持索引. 主键可以是列或表达式的任意 tuple。在MergeTree表中的数据被存储在 “parts” 中. 每一部分按照主键顺序存储数据 (数据通过主键 tuple 来排序). 所有的表的列都在各自的column.bin文件中保存。 此文件由压缩的数据块组成。每个数据块大小从64 KB 到 1 MB，依赖于平均值的大小。数据块由列值组成，按顺序连续放置。对于每一列，列值在同一个顺序上 (顺序通过主键来定义), 因此，对于对应的列，当你通过多列迭代以后来获得值。

主键自身是"稀疏的"。它不定位到每个行 ，但是仅是一些数据范围。 对于每个N-th行， 一个单独的primary.idx 文件有主键的值, N 被称为 index_granularity(通常情况下, N = 8192). 对于每个列, 我们有column.mrk 文件 ，带有 “marks”标签，对于数据文件中的每个N-th行，它是一个偏移量 。每个标签都成成对儿出现的：文件中的偏移量到压缩数据块的起始端，解压缩数据块的偏移量到数据的起始端。 通常情况下，压缩的数据块通过"marks"标签来对齐，解压缩的数据块的偏移量是0。对于primary.idx的数据通常主流在存储中，对于column.mrk文件的数据放在缓存中。

当我们从MergeTree引擎中读取数据时，我们看到了 primary.idx 数据和定位了可能包含请求数据的范围， 然后进一步看column.mrk 数据，和计算偏移量从哪开始读取这些范围。因为稀疏性, 超额的数据可能被读取。 ClickHouse 并不适合高负载的点状查询，因为带有索引粒度行的整个范围必须被读取, 整个压缩数据块必须被解压缩。我们构建的结构是索引稀疏的，因为我们必须在单台服务器上维护数万亿条数据， 对于索引来说没有显著的内存消耗。因为主键是稀疏的，它并不是唯一的：在 INSERT时，它不能够检查键的存在。在一个表内，相同的键你可以有多个行。

当你插入大量数据进入MergeTree时，数据通过主键顺序来筛选，形成一个新的部分。为了保持数据块数是低位的，有一些背景线程周期性地查询这些数据块，将他们合并到一个排序好的数据块。

这就是为什么称为MergeTree。当然，合并意味着"写入净化"。所有的部分都是非修改的：他们仅创建和删除，但是不会更新。当SELECT运行时，它将获得一个表的快照。在合并之后，我们也保持旧的部分用于故障数据恢复，所以如果我们某些合并部分的文件损坏了，我们能够根据原来的部分进行替换。

MergeTree 不是一个LSM 树，因为它不包含  “memtable” 和 “log”: 插入的数据直接写入到文件系统。这个仅适合于批量的INSERT操作，并不是每行写入，同时不能过于频繁 – 每秒一次写入是 OK 的，每秒几千次写入是不可以的。 我们使用这种方式是为了简化，因为在生产环境中，我们主要以批量插入数据为主。

MergeTree表只有一个(主)索引：没有二级索引。它允许在一个逻辑表下的多个物理表示，例如，在多个物理表中存储数据，甚至允许沿着原有的数据带有预计算的表示。

有MergeTree引擎作为背景线程来做额外的合并。示例是CollapsingMergeTree和AggregatingMergeTree。他们作为对更新的特定支持来看待。这些并不是真的更新，在背景合并运行时，因为用户没法控制时间，在MergeTreetable中的数据经常被存储到多个部分，以非完全的合并形式。

















ClickHouse 是一个真正的列式数据库管理系统（DBMS)。在 ClickHouse 中，数据始终是按列存储的，包括矢量（向量或列块）执行的过程。只要有可能，操作都是基于矢量进行分派的，而不是单个的值，这被称为«矢量化查询执行»，它有利于降低实际的数据处理开销。

> 这个想法并不新鲜，其可以追溯到 `APL` 编程语言及其后代：`A +`、`J`、`K` 和 `Q`。矢量编程被大量用于科学数据处理中。即使在关系型数据库中，这个想法也不是什么新的东西：比如，矢量编程也被大量用于 `Vectorwise` 系统中。

通常有两种不同的加速查询处理的方法：矢量化查询执行和运行时代码生成。在后者中，动态地为每一类查询生成代码，消除了间接分派和动态分派。这两种方法中，并没有哪一种严格地比另一种好。运行时代码生成可以更好地将多个操作融合在一起，从而充分利用 CPU 执行单元和流水线。矢量化查询执行不是特别实用，因为它涉及必须写到缓存并读回的临时向量。如果 L2 缓存容纳不下临时数据，那么这将成为一个问题。但矢量化查询执行更容易利用 CPU 的 SIMD 功能。朋友写的一篇[研究论文](http://15721.courses.cs.cmu.edu/spring2016/papers/p5-sompolski.pdf)表明，将两种方法结合起来是更好的选择。ClickHouse 使用了矢量化查询执行，同时初步提供了有限的运行时动态代码生成。

## 列（Columns）[ ](https://clickhouse.tech/docs/zh/development/architecture/#lie-columns)

要表示内存中的列（实际上是列块），需使用 `IColumn` 接口。该接口提供了用于实现各种关系操作符的辅助方法。几乎所有的操作都是不可变的：这些操作不会更改原始列，但是会创建一个新的修改后的列。比如，`IColumn::filter` 方法接受过滤字节掩码，用于 `WHERE` 和 `HAVING` 关系操作符中。另外的例子：`IColumn::permute` 方法支持 `ORDER BY` 实现，`IColumn::cut` 方法支持 `LIMIT` 实现等等。

不同的 `IColumn` 实现（`ColumnUInt8`、`ColumnString` 等）负责不同的列内存布局。内存布局通常是一个连续的数组。对于数据类型为整型的列，只是一个连续的数组，比如 `std::vector`。对于 `String` 列和 `Array` 列，则由两个向量组成：其中一个向量连续存储所有的 `String` 或数组元素，另一个存储每一个 `String` 或 `Array` 的起始元素在第一个向量中的偏移。而 `ColumnConst` 则仅在内存中存储一个值，但是看起来像一个列。

## 字段[ ](https://clickhouse.tech/docs/zh/development/architecture/#field)

尽管如此，有时候也可能需要处理单个值。表示单个值，可以使用 `Field`。`Field` 是 `UInt64`、`Int64`、`Float64`、`String` 和 `Array` 组成的联合。`IColumn` 拥有 `operator[]` 方法来获取第 `n` 个值成为一个 `Field`，同时也拥有 `insert` 方法将一个 `Field` 追加到一个列的末尾。这些方法并不高效，因为它们需要处理表示单一值的临时 `Field` 对象，但是有更高效的方法比如 `insertFrom` 和 `insertRangeFrom` 等。

`Field` 中并没有足够的关于一个表（table）的特定数据类型的信息。比如，`UInt8`、`UInt16`、`UInt32` 和 `UInt64` 在 `Field` 中均表示为 `UInt64`。

## 抽象漏洞[ ](https://clickhouse.tech/docs/zh/development/architecture/#chou-xiang-lou-dong)

`IColumn` 具有用于数据的常见关系转换的方法，但这些方法并不能够满足所有需求。比如，`ColumnUInt64` 没有用于计算两列和的方法，`ColumnString` 没有用于进行子串搜索的方法。这些无法计算的例程在 `Icolumn` 之外实现。

列（Columns)上的各种函数可以通过使用 `Icolumn` 的方法来提取 `Field` 值，或根据特定的 `Icolumn` 实现的数据内存布局的知识，以一种通用但不高效的方式实现。为此，函数将会转换为特定的 `IColumn` 类型并直接处理内部表示。比如，`ColumnUInt64` 具有 `getData` 方法，该方法返回一个指向列的内部数组的引用，然后一个单独的例程可以直接读写或填充该数组。实际上，«抽象漏洞（leaky abstractions）»允许我们以更高效的方式来实现各种特定的例程。

## 数据类型[ ](https://clickhouse.tech/docs/zh/development/architecture/#shu-ju-lei-xing)

`IDataType` 负责序列化和反序列化：读写二进制或文本形式的列或单个值构成的块。`IDataType` 直接与表的数据类型相对应。比如，有 `DataTypeUInt32`、`DataTypeDateTime`、`DataTypeString` 等数据类型。

`IDataType` 与 `IColumn` 之间的关联并不大。不同的数据类型在内存中能够用相同的 `IColumn` 实现来表示。比如，`DataTypeUInt32` 和 `DataTypeDateTime` 都是用 `ColumnUInt32` 或 `ColumnConstUInt32` 来表示的。另外，相同的数据类型也可以用不同的 `IColumn` 实现来表示。比如，`DataTypeUInt8` 既可以使用 `ColumnUInt8` 来表示，也可以使用过 `ColumnConstUInt8` 来表示。

`IDataType` 仅存储元数据。比如，`DataTypeUInt8` 不存储任何东西（除了 vptr）；`DataTypeFixedString` 仅存储 `N`（固定长度字符串的串长度）。

`IDataType` 具有针对各种数据格式的辅助函数。比如如下一些辅助函数：序列化一个值并加上可能的引号；序列化一个值用于 JSON 格式；序列化一个值作为 XML 格式的一部分。辅助函数与数据格式并没有直接的对应。比如，两种不同的数据格式 `Pretty` 和 `TabSeparated` 均可以使用 `IDataType` 接口提供的 `serializeTextEscaped` 这一辅助函数。

## 块（Block）[ ](https://clickhouse.tech/docs/zh/development/architecture/#kuai-block)

`Block` 是表示内存中表的子集（chunk）的容器，是由三元组：`(IColumn, IDataType, 列名)` 构成的集合。在查询执行期间，数据是按 `Block` 进行处理的。如果我们有一个 `Block`，那么就有了数据（在 `IColumn` 对象中），有了数据的类型信息告诉我们如何处理该列，同时也有了列名（来自表的原始列名，或人为指定的用于临时计算结果的名字）。

当我们遍历一个块中的列进行某些函数计算时，会把结果列加入到块中，但不会更改函数参数中的列，因为操作是不可变的。之后，不需要的列可以从块中删除，但不是修改。这对于消除公共子表达式非常方便。

`Block` 用于处理数据块。注意，对于相同类型的计算，列名和类型对不同的块保持相同，仅列数据不同。最好把块数据（block data）和块头（block header）分离开来，因为小块大小会因复制共享指针和列名而带来很高的临时字符串开销。

## 块流（Block Streams）[ ](https://clickhouse.tech/docs/zh/development/architecture/#kuai-liu-block-streams)

块流用于处理数据。我们可以使用块流从某个地方读取数据，执行数据转换，或将数据写到某个地方。`IBlockInputStream` 具有 `read` 方法，其能够在数据可用时获取下一个块。`IBlockOutputStream` 具有 `write` 方法，其能够将块写到某处。

块流负责：

1. 读或写一个表。表仅返回一个流用于读写块。
2. 完成数据格式化。比如，如果你打算将数据以 `Pretty` 格式输出到终端，你可以创建一个块输出流，将块写入该流中，然后进行格式化。
3. 执行数据转换。假设你现在有 `IBlockInputStream` 并且打算创建一个过滤流，那么你可以创建一个 `FilterBlockInputStream` 并用 `IBlockInputStream` 进行初始化。之后，当你从 `FilterBlockInputStream` 中拉取块时，会从你的流中提取一个块，对其进行过滤，然后将过滤后的块返回给你。查询执行流水线就是以这种方式表示的。

还有一些更复杂的转换。比如，当你从 `AggregatingBlockInputStream` 拉取数据时，会从数据源读取全部数据进行聚集，然后将聚集后的数据流返回给你。另一个例子：`UnionBlockInputStream` 的构造函数接受多个输入源和多个线程，其能够启动多线程从多个输入源并行读取数据。

> 块流使用«pull»方法来控制流：当你从第一个流中拉取块时，它会接着从嵌套的流中拉取所需的块，然后整个执行流水线开始工作。»pull«和«push»都不是最好的方案，因为控制流不是明确的，这限制了各种功能的实现，比如多个查询同步执行（多个流水线合并到一起）。这个限制可以通过协程或直接运行互相等待的线程来解决。如果控制流明确，那么我们会有更多的可能性：如果我们定位了数据从一个计算单元传递到那些外部的计算单元中其中一个计算单元的逻辑。阅读这篇[文章](http://journal.stuffwithstuff.com/2013/01/13/iteration-inside-and-out/)来获取更多的想法。

我们需要注意，查询执行流水线在每一步都会创建临时数据。我们要尽量使块的大小足够小，从而 CPU 缓存能够容纳下临时数据。在这个假设下，与其他计算相比，读写临时数据几乎是没有任何开销的。我们也可以考虑一种替代方案：将流水线中的多个操作融合在一起，使流水线尽可能短，并删除大量临时数据。这可能是一个优点，但同时也有缺点。比如，拆分流水线使得中间数据缓存、获取同时运行的类似查询的中间数据以及相似查询的流水线合并等功能很容易实现。

## 格式（Formats）[ ](https://clickhouse.tech/docs/zh/development/architecture/#ge-shi-formats)

数据格式同块流一起实现。既有仅用于向客户端输出数据的»展示«格式，如 `IBlockOutputStream` 提供的 `Pretty` 格式，也有其它输入输出格式，比如 `TabSeparated` 或 `JSONEachRow`。

此外还有行流：`IRowInputStream` 和 `IRowOutputStream`。它们允许你按行 pull/push 数据，而不是按块。行流只需要简单地面向行格式实现。包装器 `BlockInputStreamFromRowInputStream` 和 `BlockOutputStreamFromRowOutputStream` 允许你将面向行的流转换为正常的面向块的流。

## I/O[ ](https://clickhouse.tech/docs/zh/development/architecture/#io)

对于面向字节的输入输出，有 `ReadBuffer` 和 `WriteBuffer` 这两个抽象类。它们用来替代 C++ 的 `iostream`。不用担心：每个成熟的 C++ 项目都会有充分的理由使用某些东西来代替 `iostream`。

`ReadBuffer` 和 `WriteBuffer` 由一个连续的缓冲区和指向缓冲区中某个位置的一个指针组成。实现中，缓冲区可能拥有内存，也可能不拥有内存。有一个虚方法会使用随后的数据来填充缓冲区（针对 `ReadBuffer`）或刷新缓冲区（针对 `WriteBuffer`），该虚方法很少被调用。

`ReadBuffer` 和 `WriteBuffer` 的实现用于处理文件、文件描述符和网络套接字（socket），也用于实现压缩（`CompressedWriteBuffer` 在写入数据前需要先用一个 `WriteBuffer` 进行初始化并进行压缩）和其它用途。`ConcatReadBuffer`、`LimitReadBuffer` 和 `HashingWriteBuffer` 的用途正如其名字所描述的一样。

`ReadBuffer` 和 `WriteBuffer` 仅处理字节。为了实现格式化输入和输出（比如以十进制格式写一个数字），`ReadHelpers` 和 `WriteHelpers` 头文件中有一些辅助函数可用。

让我们来看一下，当你把一个结果集以 `JSON` 格式写到标准输出（stdout）时会发生什么。你已经准备好从 `IBlockInputStream` 获取结果集，然后创建 `WriteBufferFromFileDescriptor(STDOUT_FILENO)` 用于写字节到标准输出，创建 `JSONRowOutputStream` 并用 `WriteBuffer` 初始化，用于将行以 `JSON` 格式写到标准输出，你还可以在其上创建 `BlockOutputStreamFromRowOutputStream`，将其表示为 `IBlockOutputStream`。然后调用 `copyData` 将数据从 `IBlockInputStream` 传输到 `IBlockOutputStream`，一切工作正常。在内部，`JSONRowOutputStream` 会写入 JSON 分隔符，并以指向 `IColumn` 的引用和行数作为参数调用 `IDataType::serializeTextJSON` 函数。随后，`IDataType::serializeTextJSON` 将会调用 `WriteHelpers.h` 中的一个方法：比如，`writeText` 用于数值类型，`writeJSONString` 用于 `DataTypeString` 。

## 表（Tables）[ ](https://clickhouse.tech/docs/zh/development/architecture/#biao-tables)

表由 `IStorage` 接口表示。该接口的不同实现对应不同的表引擎。比如 `StorageMergeTree`、`StorageMemory` 等。这些类的实例就是表。

`IStorage` 中最重要的方法是 `read` 和 `write`，除此之外还有 `alter`、`rename` 和 `drop` 等方法。`read` 方法接受如下参数：需要从表中读取的列集，需要执行的 `AST` 查询，以及所需返回的流的数量。`read` 方法的返回值是一个或多个 `IBlockInputStream` 对象，以及在查询执行期间在一个表引擎内完成的关于数据处理阶段的信息。

在大多数情况下，`read` 方法仅负责从表中读取指定的列，而不会进行进一步的数据处理。进一步的数据处理均由查询解释器完成，不由 `IStorage` 负责。

但是也有值得注意的例外：

- AST 查询被传递给 `read` 方法，表引擎可以使用它来判断是否能够使用索引，从而从表中读取更少的数据。
- 有时候，表引擎能够将数据处理到一个特定阶段。比如，`StorageDistributed` 可以向远程服务器发送查询，要求它们将来自不同的远程服务器能够合并的数据处理到某个阶段，并返回预处理后的数据，然后查询解释器完成后续的数据处理。

表的 `read` 方法能够返回多个 `IBlockInputStream` 对象以允许并行处理数据。多个块输入流能够从一个表中并行读取。然后你可以通过不同的转换对这些流进行装饰（比如表达式求值或过滤），转换过程能够独立计算，并在其上创建一个 `UnionBlockInputStream`，以并行读取多个流。

另外也有 `TableFunction`。`TableFunction` 能够在查询的 `FROM` 字句中返回一个临时的 `IStorage` 以供使用。

要快速了解如何实现自己的表引擎，可以查看一些简单的表引擎，比如 `StorageMemory` 或 `StorageTinyLog`。

> 作为 `read` 方法的结果，`IStorage` 返回 `QueryProcessingStage` - 关于 storage 里哪部分查询已经被计算的信息。当前我们仅有非常粗粒度的信息。Storage 无法告诉我们«对于这个范围的数据，我已经处理完了 WHERE 字句里的这部分表达式»。我们需要在这个地方继续努力。

## 解析器（Parsers）[ ](https://clickhouse.tech/docs/zh/development/architecture/#jie-xi-qi-parsers)

查询由一个手写递归下降解析器解析。比如， `ParserSelectQuery` 只是针对查询的不同部分递归地调用下层解析器。解析器创建 `AST`。`AST` 由节点表示，节点是 `IAST` 的实例。

> 由于历史原因，未使用解析器生成器。

## 解释器（Interpreters）[ ](https://clickhouse.tech/docs/zh/development/architecture/#jie-shi-qi-interpreters)

解释器负责从 `AST` 创建查询执行流水线。既有一些简单的解释器，如 `InterpreterExistsQuery` 和 `InterpreterDropQuery`，也有更复杂的解释器，如 `InterpreterSelectQuery`。查询执行流水线由块输入或输出流组成。比如，`SELECT` 查询的解释结果是从 `FROM` 字句的结果集中读取数据的 `IBlockInputStream`；`INSERT` 查询的结果是写入需要插入的数据的 `IBlockOutputStream`；`SELECT INSERT` 查询的解释结果是 `IBlockInputStream`，它在第一次读取时返回一个空结果集，同时将数据从 `SELECT` 复制到 `INSERT`。

`InterpreterSelectQuery` 使用 `ExpressionAnalyzer` 和 `ExpressionActions` 机制来进行查询分析和转换。这是大多数基于规则的查询优化完成的地方。`ExpressionAnalyzer` 非常混乱，应该进行重写：不同的查询转换和优化应该被提取出来并划分成不同的类，从而允许模块化转换或查询。

## 函数（Functions）[ ](https://clickhouse.tech/docs/zh/development/architecture/#han-shu-functions)

函数既有普通函数，也有聚合函数。对于聚合函数，请看下一节。

普通函数不会改变行数 - 它们的执行看起来就像是独立地处理每一行数据。实际上，函数不会作用于一个单独的行上，而是作用在以 `Block` 为单位的数据上，以实现向量查询执行。

还有一些杂项函数，比如 [块大小](https://clickhouse.tech/docs/zh/sql-reference/functions/other-functions/#function-blocksize)、[rowNumberInBlock](https://clickhouse.tech/docs/zh/sql-reference/functions/other-functions/#function-rownumberinblock)，以及 [跑累积](https://clickhouse.tech/docs/zh/sql-reference/functions/other-functions/#function-runningaccumulate)，它们对块进行处理，并且不遵从行的独立性。

ClickHouse 具有强类型，因此隐式类型转换不会发生。如果函数不支持某个特定的类型组合，则会抛出异常。但函数可以通过重载以支持许多不同的类型组合。比如，`plus` 函数（用于实现 `+` 运算符）支持任意数字类型的组合：`UInt8` + `Float32`，`UInt16` + `Int8` 等。同时，一些可变参数的函数能够级接收任意数目的参数，比如 `concat` 函数。

实现函数可能有些不方便，因为函数的实现需要包含所有支持该操作的数据类型和 `IColumn` 类型。比如，`plus` 函数能够利用 C++ 模板针对不同的数字类型组合、常量以及非常量的左值和右值进行代码生成。

> 这是一个实现动态代码生成的好地方，从而能够避免模板代码膨胀。同样，运行时代码生成也使得实现融合函数成为可能，比如融合«乘-加»，或者在单层循环迭代中进行多重比较。

由于向量查询执行，函数不会«短路»。比如，如果你写 `WHERE f(x) AND g(y)`，两边都会进行计算，即使是对于 `f(x)` 为 0 的行（除非 `f(x)` 是零常量表达式）。但是如果 `f(x)` 的选择条件很高，并且计算 `f(x)` 比计算 `g(y)` 要划算得多，那么最好进行多遍计算：首先计算 `f(x)`，根据计算结果对列数据进行过滤，然后计算 `g(y)`，之后只需对较小数量的数据进行过滤。

## 聚合函数[ ](https://clickhouse.tech/docs/zh/development/architecture/#ju-he-han-shu)

聚合函数是状态函数。它们将传入的值激活到某个状态，并允许你从该状态获取结果。聚合函数使用 `IAggregateFunction` 接口进行管理。状态可以非常简单（`AggregateFunctionCount` 的状态只是一个单一的`UInt64` 值），也可以非常复杂（`AggregateFunctionUniqCombined` 的状态是由一个线性数组、一个散列表和一个 `HyperLogLog` 概率数据结构组合而成的）。

为了能够在执行一个基数很大的 `GROUP BY` 查询时处理多个聚合状态，需要在 `Arena`（一个内存池）或任何合适的内存块中分配状态。状态可以有一个非平凡的构造器和析构器：比如，复杂的聚合状态能够自己分配额外的内存。这需要注意状态的创建和销毁并恰当地传递状态的所有权，以跟踪谁将何时销毁状态。

聚合状态可以被序列化和反序列化，以在分布式查询执行期间通过网络传递或者在内存不够的时候将其写到硬盘。聚合状态甚至可以通过 `DataTypeAggregateFunction` 存储到一个表中，以允许数据的增量聚合。

> 聚合函数状态的序列化数据格式目前尚未版本化。如果只是临时存储聚合状态，这样是可以的。但是我们有 `AggregatingMergeTree` 表引擎用于增量聚合，并且人们已经在生产中使用它。这就是为什么在未来当我们更改任何聚合函数的序列化格式时需要增加向后兼容的支持。

## 服务器（Server）[ ](https://clickhouse.tech/docs/zh/development/architecture/#fu-wu-qi-server)

服务器实现了多个不同的接口：

- 一个用于任何外部客户端的 HTTP 接口。
- 一个用于本机 ClickHouse 客户端以及在分布式查询执行中跨服务器通信的 TCP 接口。
- 一个用于传输数据以进行拷贝的接口。

在内部，它只是一个没有协程、纤程等的基础多线程服务器。服务器不是为处理高速率的简单查询设计的，而是为处理相对低速率的复杂查询设计的，每一个复杂查询能够对大量的数据进行处理分析。

服务器使用必要的查询执行需要的环境初始化 `Context` 类：可用数据库列表、用户和访问权限、设置、集群、进程列表和查询日志等。这些环境被解释器使用。

我们维护了服务器 TCP 协议的完全向后向前兼容性：旧客户端可以和新服务器通信，新客户端也可以和旧服务器通信。但是我们并不想永久维护它，我们将在大约一年后删除对旧版本的支持。

> 对于所有的外部应用，我们推荐使用 HTTP 接口，因为该接口很简单，容易使用。TCP 接口与内部数据结构的联系更加紧密：它使用内部格式传递数据块，并使用自定义帧来压缩数据。我们没有发布该协议的 C 库，因为它需要链接大部分的 ClickHouse 代码库，这是不切实际的。

## 分布式查询执行[ ](https://clickhouse.tech/docs/zh/development/architecture/#fen-bu-shi-cha-xun-zhi-xing)

集群设置中的服务器大多是独立的。你可以在一个集群中的一个或多个服务器上创建一个 `Distributed` 表。`Distributed` 表本身并不存储数据，它只为集群的多个节点上的所有本地表提供一个«视图（view）»。当从 `Distributed` 表中进行 SELECT 时，它会重写该查询，根据负载平衡设置来选择远程节点，并将查询发送给节点。`Distributed` 表请求远程服务器处理查询，直到可以合并来自不同服务器的中间结果的阶段。然后它接收中间结果并进行合并。分布式表会尝试将尽可能多的工作分配给远程服务器，并且不会通过网络发送太多的中间数据。

> 当 `IN` 或 `JOIN` 子句中包含子查询并且每个子查询都使用分布式表时，事情会变得更加复杂。我们有不同的策略来执行这些查询。

分布式查询执行没有全局查询计划。每个节点都有针对自己的工作部分的本地查询计划。我们仅有简单的一次性分布式查询执行：将查询发送给远程节点，然后合并结果。但是对于具有高基数的 `GROUP BY` 或具有大量临时数据的 `JOIN` 这样困难的查询的来说，这是不可行的：在这种情况下，我们需要在服务器之间«改组»数据，这需要额外的协调。ClickHouse 不支持这类查询执行，我们需要在这方面进行努力。

## 合并树[ ](https://clickhouse.tech/docs/zh/development/architecture/#merge-tree)

`MergeTree` 是一系列支持按主键索引的存储引擎。主键可以是一个任意的列或表达式的元组。`MergeTree` 表中的数据存储于«分块»中。每一个分块以主键序存储数据（数据按主键元组的字典序排序）。表的所有列都存储在这些«分块»中分离的 `column.bin` 文件中。`column.bin` 文件由压缩块组成，每一个块通常是 64 KB 到 1 MB 大小的未压缩数据，具体取决于平均值大小。这些块由一个接一个连续放置的列值组成。每一列的列值顺序相同（顺序由主键定义），因此当你按多列进行迭代时，你能够得到相应列的值。

主键本身是«稀疏»的。它并不是索引单一的行，而是索引某个范围内的数据。一个单独的 `primary.idx` 文件具有每个第 N 行的主键值，其中 N 称为 `index_granularity`（通常，N = 8192）。同时，对于每一列，都有带有标记的 `column.mrk` 文件，该文件记录的是每个第 N 行在数据文件中的偏移量。每个标记是一个 pair：文件中的偏移量到压缩块的起始，以及解压缩块中的偏移量到数据的起始。通常，压缩块根据标记对齐，并且解压缩块中的偏移量为 0。`primary.idx` 的数据始终驻留在内存，同时 `column.mrk` 的数据被缓存。

当我们要从 `MergeTree` 的一个分块中读取部分内容时，我们会查看 `primary.idx` 数据并查找可能包含所请求数据的范围，然后查看 `column.mrk` 并计算偏移量从而得知从哪里开始读取些范围的数据。由于稀疏性，可能会读取额外的数据。ClickHouse 不适用于高负载的简单点查询，因为对于每一个键，整个 `index_granularity` 范围的行的数据都需要读取，并且对于每一列需要解压缩整个压缩块。我们使索引稀疏，是因为每一个单一的服务器需要在索引没有明显内存消耗的情况下，维护数万亿行的数据。另外，由于主键是稀疏的，导致其不是唯一的：无法在 INSERT 时检查一个键在表中是否存在。你可以在一个表中使用同一个键创建多个行。

当你向 `MergeTree` 中插入一堆数据时，数据按主键排序并形成一个新的分块。为了保证分块的数量相对较少，有后台线程定期选择一些分块并将它们合并成一个有序的分块，这就是 `MergeTree` 的名称来源。当然，合并会导致«写入放大»。所有的分块都是不可变的：它们仅会被创建和删除，不会被修改。当运行 `SELECT` 查询时，`MergeTree` 会保存一个表的快照（分块集合）。合并之后，还会保留旧的分块一段时间，以便发生故障后更容易恢复，因此如果我们发现某些合并后的分块可能已损坏，我们可以将其替换为原分块。

`MergeTree` 不是 LSM 树，因为它不包含»memtable«和»log«：插入的数据直接写入文件系统。这使得它仅适用于批量插入数据，而不适用于非常频繁地一行一行插入 - 大约每秒一次是没问题的，但是每秒一千次就会有问题。我们这样做是为了简单起见，因为我们已经在我们的应用中批量插入数据。

> `MergeTree` 表只能有一个（主）索引：没有任何辅助索引。在一个逻辑表下，允许有多个物理表示，比如，可以以多个物理顺序存储数据，或者同时表示预聚合数据和原始数据。

有些 `MergeTree` 引擎会在后台合并期间做一些额外工作，比如 `CollapsingMergeTree` 和 `AggregatingMergeTree`。这可以视为对更新的特殊支持。请记住这些不是真正的更新，因为用户通常无法控制后台合并将会执行的时间，并且 `MergeTree` 中的数据几乎总是存储在多个分块中，而不是完全合并的形式。

## 复制（Replication）[ ](https://clickhouse.tech/docs/zh/development/architecture/#fu-zhi-replication)

ClickHouse 中的复制是基于表实现的。你可以在同一个服务器上有一些可复制的表和不可复制的表。你也可以以不同的方式进行表的复制，比如一个表进行双因子复制，另一个进行三因子复制。

复制是在 `ReplicatedMergeTree` 存储引擎中实现的。`ZooKeeper` 中的路径被指定为存储引擎的参数。`ZooKeeper` 中所有具有相同路径的表互为副本：它们同步数据并保持一致性。只需创建或删除表，就可以实现动态添加或删除副本。

复制使用异步多主机方案。你可以将数据插入到与 `ZooKeeper` 进行会话的任意副本中，并将数据复制到所有其它副本中。由于 ClickHouse 不支持 UPDATEs，因此复制是无冲突的。由于没有对插入的仲裁确认，如果一个节点发生故障，刚刚插入的数据可能会丢失。

用于复制的元数据存储在 ZooKeeper 中。其中一个复制日志列出了要执行的操作。操作包括：获取分块、合并分块和删除分区等。每一个副本将复制日志复制到其队列中，然后执行队列中的操作。比如，在插入时，在复制日志中创建«获取分块»这一操作，然后每一个副本都会去下载该分块。所有副本之间会协调进行合并以获得相同字节的结果。所有的分块在所有的副本上以相同的方式合并。为实现该目的，其中一个副本被选为领导者，该副本首先进行合并，并把«合并分块»操作写到日志中。

复制是物理的：只有压缩的分块会在节点之间传输，查询则不会。为了降低网络成本（避免网络放大），大多数情况下，会在每一个副本上独立地处理合并。只有在存在显著的合并延迟的情况下，才会通过网络发送大块的合并分块。

另外，每一个副本将其状态作为分块和校验和组成的集合存储在 ZooKeeper 中。当本地文件系统中的状态与 ZooKeeper 中引用的状态不同时，该副本会通过从其它副本下载缺失和损坏的分块来恢复其一致性。当本地文件系统中出现一些意外或损坏的数据时，ClickHouse 不会将其删除，而是将其移动到一个单独的目录下并忘记它。

> ClickHouse 集群由独立的分片组成，每一个分片由多个副本组成。集群不是弹性的，因此在添加新的分片后，数据不会自动在分片之间重新平衡。相反，集群负载将变得不均衡。该实现为你提供了更多控制，对于相对较小的集群，例如只有数十个节点的集群来说是很好的。但是对于我们在生产中使用的具有数百个节点的集群来说，这种方法成为一个重大缺陷。我们应该实现一个表引擎，使得该引擎能够跨集群扩展数据，同时具有动态复制的区域，这些区域能够在集群之间自动拆分和平衡。