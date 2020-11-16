<Error> Application: DB::Exception: Part `20200513_1_5_1` was found on disk `default` which is not defined in the storage policy。



这里原因主要是因为 磁盘目录 disk 那么重复使用导致重启失败的问题

┌─name────┬─path──────────────────────────────────┬────free_space─┬───total_space─┬─keep_free_space─┐
│ default │ /data0/**/clickhouse/defaultdata/ │ 1846217543680 │ 1948872605696 │               0 │
│ disk3  │ /data3/**/clickhouse/data/       │ 1848058601472 │ 1948872605696 │               0 │
│ disk2  │ /data2/**/clickhouse/data/       │ 1847911780352 │ 1948872605696 │               0 │
│ disk1   │ /data1/**/clickhouse/data/        │ 1846217543680 │ 1948872605696 │               0 │
│ disk0   │ /data0/**/clickhouse/data/        │ 1847497854976 │ 1948872605696 │               0 │
└─────────┴───────────────────────────────────────┴───────────────┴───────────────┴─────────────────┘



default 磁盘跟disk0 磁盘重复使用

```
    <storage_configuration>
        <disks>
            <disk0>
                <path>/data0/XXX/clickhouse/data/</path>
            </disk0>
            <disk1>
                <path>/data1/XX/clickhouse/data/</path>
            </disk1>
            <disk2>
                <path>/data2/XXX/clickhouse/data/</path>
            </disk2>
            <disk3>
                <path>/data3/XXX/clickhouse/data/</path>
            </disk3>
        </disks>
        <policies>
            <jdob_ha>
                <volumes>
                    <hot>
                        <disk>disk0</disk>
                        <disk>disk1</disk>
                        <disk>disk2</disk>
                        <disk>disk3</disk>
                                                <!-- <max_data_part_size_bytes>3298534883328</max_data_part_size_bytes> -->
                    </hot>
                </volumes>
            </jdob_ha>
        </policies>
    </storage_configuration>
```





### 解决方案

```
    <storage_configuration>
        <disks>
            <disk1>
                <path>/data1/XX/clickhouse/data/</path>
            </disk1>
            <disk2>
                <path>/data2/XXX/clickhouse/data/</path>
            </disk2>
            <disk3>
                <path>/data3/XXX/clickhouse/data/</path>
            </disk3>
        </disks>
        <policies>
            <jdob_ha>
                <volumes>
                    <hot>
                        <disk>default</disk>
                        <disk>disk1</disk>
                        <disk>disk2</disk>
                        <disk>disk3</disk>
                                                <!-- <max_data_part_size_bytes>3298534883328</max_data_part_size_bytes> -->
                    </hot>
                </volumes>
            </jdob_ha>
        </policies>
    </storage_configuration>
```

