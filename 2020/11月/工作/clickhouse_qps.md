```xml
<dictionaries>
    <dictionary>
        <name>int20M</name>
        <source>
            <clickhouse>
                <host>localhost</host>
                <port>9000</port>
                <user>default</user>
                <password></password>
                <db>default</db>
                <table>int20M</table>
            </clickhouse>
        </source>
        <lifetime>0</lifetime>
        <layout><hashed /></layout>
        <structure>
            <id><name>id</name></id>
            <attribute>
                <name>value</name>
                <type>Float32</type>
                <null_value>0</null_value>
            </attribute>
        </structure>
    </dictionary>
</dictionaries>
```

