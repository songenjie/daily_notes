```c++
            /*if (data.source_column_index < data.source_columns.size())
            {
                identifier.alias = *(data.source_columns.begin(data.source_column_index));
                data.source_column_index++;
            }*/

            /*if (data.source_column_index < data.source_columns.size())
            {
                UInt16 column_index = 0;
                for (auto const & source_column : data.source_columns)
                {
                    if (column_index++ == data.source_column_index)
                    {
                        identifier.alias = source_column;
                        data.source_column_index++;
                        break;
                    }
                }
            }*/
```

