> where user default come from?

Distributed table uses the user/password you described with cluster definition

https://clickhouse.yandex/docs/en/operations/table_engines/distributed/

```xml
   <remote_servers>
      <test>
           <shard>
               <replica>
                   <host>host</host>
                   <port>port</port>
                   <user>username</user>
                   <password>password</password>
               </replica>
           </shard>
       </test>
   </remote_servers>
```