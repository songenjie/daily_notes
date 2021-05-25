```c++
    else if (create.select)
    {
        Block as_select_sample = InterpreterSelectWithUnionQuery::getSampleBlock(create.select->clone(), context);
        properties.columns = ColumnsDescription(as_select_sample.getNamesAndTypesList());
        if (create.is_materialized_view && create.to_table_id)
        {
            String to_database_name = getContext()->resolveDatabase(create.to_table_id.database_name);
            StoragePtr to_storage = DatabaseCatalog::instance().getTable({to_database_name, create.to_table_id.table_name}, context);
            as_storage_lock = to_storage->lockForShare(context.getCurrentQueryId(), context.getSettingsRef().lock_acquire_timeout);
            auto to_storage_metadata = to_storage->getInMemoryMetadataPtr();
            auto to_storage_columns = to_storage_metadata->getColumns();
            for (auto const & column : properties.columns)
            {
                auto bfind = false;
                for (auto const & to_storage_column : to_storage_columns)
                {
                    if (to_storage_column.name == column.name)
                    {
                        bfind = true;
                        break;
                    }
                }
                if (!bfind)
                    throw Exception(
                        "column: " + column.name + " not included in table:" + to_database_name + "." + create.to_table_id.table_name
                            + "! you may need alias it .",
                        ErrorCodes::INCORRECT_QUERY);
            }
        }
    }
```

