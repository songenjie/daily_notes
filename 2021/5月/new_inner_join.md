```
CREATE MATERIALIZED VIEW meterialized_table_3_5 TO meterialized_table_storage AS
SELECT
    A.day,
    B.id,
    B.number
FROM LEFT_TABLE2 AS A
INNER JOIN RIGHT_TABLE2 AS B ON A.id = B.id

Query id: 9a8d97c8-a247-4f96-a56e-fbd19f18de4f


0 rows in set. Elapsed: 0.005 sec.

Received exception from server (version 21.6.1):
Code: 352. DB::Exception: Received from 127.0.0.1:19000. DB::Exception: Cannot detect left and right JOIN keys. JOIN ON section is ambiguous.: While processing A.id = B.id.



```

