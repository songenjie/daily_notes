```c++
    /// @note It expects that only table (not column) identifiers are visited.
    void visit(const ASTIdentifier & identifier, ASTPtr & ast) const
    {
        if (!identifier.compound())
        {
            ast = createTableIdentifier(database_name, identifier.name());
            ast->setAlias(const_cast<String &>(identifier.alias));
        }
    }


        if (!identifier.compound())
        {
            ast = createTableIdentifier(database_name, identifier.name());
            ast->setAlias(const_cast<String &>(identifier.alias));
            ast->setAlias(typeid_cast<const String &>(identifier.alias));
        }
```

https://github.com/ClickHouse/ClickHouse/pull/25620/files





http://www.cplusplus.com/forum/general/8571/