```
2021.05.12 14:35:51.121086 [ 4963648 ] {2bb99730-f184-478e-a2b0-fe694347f0dc} <Error> executeQuery: Code: 59, e.displayText() = DB::Exception: Invalid type for filter in WHERE: String (version 21.6.1.1) (from [::ffff:127.0.0.1]:53979) (in query: SELECT DISTINCT arrayJoin(extractAll(name, '[\\w_]{2,}')) AS res FROM (SELECT name FROM system.functions UNION ALL SELECT name FROM system.table_engines UNION ALL SELECT name FROM system.formats UNION ALL SELECT name FROM system.table_functions UNION ALL SELECT name FROM system.data_type_families UNION ALL SELECT name FROM system.merge_tree_settings UNION ALL SELECT name FROM system.settings UNION ALL SELECT cluster FROM system.clusters UNION ALL SELECT macro FROM system.macros UNION ALL SELECT policy_name FROM system.storage_policies UNION ALL SELECT concat(func.name, comb.name) FROM system.functions AS func CROSS JOIN system.aggregate_function_combinators AS comb WHERE is_aggregate UNION ALL SELECT name FROM system.databases LIMIT 10000 UNION ALL SELECT DISTINCT name FROM system.tables LIMIT 10000 UNION ALL SELECT DISTINCT name FROM system.dictionaries LIMIT 10000 UNION ALL SELECT DISTINCT name FROM system.columns LIMIT 10000) WHERE notEmpty(res)), Stack trace (when copying this message, always include the lines below):

<Empty trace>

2021.05.12 14:35:51.121834 [ 4963648 ] {2bb99730-f184-478e-a2b0-fe694347f0dc} <Error> TCPHandler: Code: 59, e.displayText() = DB::Exception: Invalid type for filter in WHERE: String, Stack trace:

<Empty trace>
```




-- change 
src/Interpreters/AddDefaultDatabaseVisitor.h  106 
```c++
    void visit(const ASTIdentifier & identifier, ASTPtr & ast) const
    {
        if (!identifier.compound())
        {
            ast = createTableIdentifier(database_name, identifier.name());
            ast->setAlias(identifier.alias);
        }
    }
```


src/Interpreters/CollectJoinOnKeysVisitor.cpp 195
```c++
        if (!membership)
        {
            //alias
            String join_column_name = identifier->name();
            const size_t pos = join_column_name.find(".");
            if (pos != join_column_name.npos)
                join_column_name = join_column_name.substr(pos + 1, join_column_name.length());
            else
                throw Exception("name " + join_column_name + " errors! ", ErrorCodes::AMBIGUOUS_COLUMN_NAME);

            bool in_left_table = data.left_table.hasColumn(join_column_name);
            bool in_right_table = data.right_table.hasColumn(join_column_name);

```


src/Interpreters/TranslateQualifiedNamesVisitor.cpp
```c++
void TranslateQualifiedNamesMatcher::visit(ASTIdentifier & identifier, ASTPtr &, Data & data)
{
    if (IdentifierSemantic::getColumnName(identifier))
    {
        String short_name = identifier.shortName();

        UInt256 column_index = 0;
        for (auto const & source_column : data.source_columns)
        {
            if (column_index++ == data.source_column_index)
            {
                identifier.alias = source_column;
                data.source_column_index++;
                break;
            }
        }
```

src/Interpreters/TranslateQualifiedNamesVisitor.h
```c++
class TranslateQualifiedNamesMatcher
{
public:
    using Visitor = InDepthNodeVisitor<TranslateQualifiedNamesMatcher, true>;

    struct Data
    {
        const NameSet source_columns;
        const TablesWithColumns & tables;
        std::unordered_set<String> join_using_columns;
        bool has_columns;
        UInt256 source_column_index = 0;

        Data(const NameSet & source_columns_, const TablesWithColumns & tables_, bool has_columns_ = true)
            : source_columns(source_columns_)
            , tables(tables_)
            , has_columns(has_columns_)
        {}
```