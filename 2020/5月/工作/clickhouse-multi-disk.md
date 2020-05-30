
config.xml

<storage_configuration>
    <disks> <!-- 可以在这个节点下配置磁盘信息 -->
        <fast_disk> <!-- disk name，自定义 -->
            <path>/mnt/fast_ssd/clickhouse</path>
        </fast_disk>
        <disk1>
            <path>/mnt/hdd1/clickhouse</path>
            <keep_free_space_bytes>10485760</keep_free_space_bytes>
        </disk1>
        <disk2>
            <path>/mnt/hdd2/clickhouse</path>
            <keep_free_space_bytes>10485760</keep_free_space_bytes>
        </disk2>
    </disks>
    
    <policies>
       <!--定义的第一个policy-->
       <hdd_in_order> 
            <volumes>
                <single> 
                    <disk>disk1</disk>
                    <disk>disk2</disk>
                </single>
            </volumes>
        </hdd_in_order>
        
       <!--定义的第二个policy-->
        <moving_from_ssd_to_hdd><!-- policy name，自定义 -->
            <volumes>
                <hot><!-- volume name，自定义 -->
                    <disk>fast_disk</disk>
                    <max_data_part_size_bytes>1073741824</max_data_part_size_bytes>
                </hot>
                <cold>
                    <disk>disk1</disk>
                </cold>            
            </volumes>
            <move_factor>0.2</move_factor>
        </moving_from_ssd_to_hdd>
    </policies>    
</storage_configuration>

|参数|含义|其他|
|---|---|---|
keep_free_space_bytes| 最少需要保存多少磁盘空间 | | 
max_data_part_size_bytes| 定义part 的最大大小，超过阀值直接移动到下一个盘里面| |
move_factor | 定义百分比，剩余空间低于阀值直接移动到下一个盘里 |默认是是0.1|

3. how to use 
```
create table 
SETTINGS storage_policy = "{POLICY-NAME}"
```

4. move partition manually
ALTER TABLE table_name MOVE PARTITION|PART partition_expr TO DISK|VOLUME 'disk_name'

example

(1)ALTER TABLE hits MOVE PART '20190301_14343_16206_438' TO VOLUME 'slow'
(2)ALTER TABLE hits MOVE PARTITION '2019-09-01' TO DISK 'fast_ssd'
