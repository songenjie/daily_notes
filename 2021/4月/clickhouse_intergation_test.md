

```
./tests/integration/runner --binary /export/home/songenjie/songenjie/ClickHouse/build/programs/clickhouse --bridge-binary /export/home/songenjie/songenjie/ClickHouse/build/programs/clickhouse-odbc-bridge  --base-configs-dir /export/home/songenjie/songenjie/ClickHouse/programs/server  test_fetch_partition_from_auxiliary_zookeeper
2021-04-09 14:36:42,283 ClickHouse root is not set. Will use /export/home/songenjie/songenjie/ClickHouse
2021-04-09 14:36:42,283 Cases dir is not set. Will use /export/home/songenjie/songenjie/ClickHouse/tests/integration
2021-04-09 14:36:42,283 src dir is not set. Will use /export/home/songenjie/songenjie/ClickHouse/src
2021-04-09 14:36:42,284 base_configs_dir: /export/home/songenjie/songenjie/ClickHouse/programs/server,  binary: /export/home/songenjie/songenjie/ClickHouse/build/programs/clickhouse, cases_dir: /export/home/songenjie/songenjie/ClickHouse/tests/integration
clickhouse_integration_tests_volume
Running pytest container as: 'docker run --net=host -it --rm --name clickhouse_integration_tests --privileged --volume=/export/home/songenjie/songenjie/ClickHouse/build/programs/clickhouse-odbc-bridge:/clickhouse-odbc-bridge --volume=/export/home/songenjie/songenjie/ClickHouse/build/programs/clickhouse:/clickhouse         --volume=/export/home/songenjie/songenjie/ClickHouse/programs/server:/clickhouse-config --volume=/export/home/songenjie/songenjie/ClickHouse/tests/integration:/ClickHouse/tests/integration         --volume=/export/home/songenjie/songenjie/ClickHouse/src/Server/grpc_protos:/ClickHouse/src/Server/grpc_protos         --volume=clickhouse_integration_tests_volume:/var/lib/docker  -e PYTEST_OPTS='test_fetch_partition_from_auxiliary_zookeeper' yandex/clickhouse-integration-tests-runner:latest '.
Start tests
======================================================================================================== test session starts =========================================================================================================
platform linux -- Python 3.6.9, pytest-6.2.3, py-1.10.0, pluggy-0.13.1
rootdir: /ClickHouse/tests/integration, configfile: pytest.ini
plugins: timeout-1.4.2
timeout: 300.0s
timeout method: signal
timeout func_only: False
```









docker run --net=host -it --rm --name clickhouse_integration_tests --privileged --volume=/export/home/songenjie/songenjie/ClickHouse/build/programs/clickhouse-odbc-bridge:/clickhouse-odbc-bridge --volume=/export/home/songenjie/songenjie/ClickHouse/build/programs/clickhouse:/clickhouse         --volume=/export/home/songenjie/songenjie/ClickHouse/programs/server:/clickhouse-config --volume=/export/home/songenjie/songenjie/ClickHouse/tests/integration:/ClickHouse/tests/integration         --volume=/export/home/songenjie/songenjie/ClickHouse/src/Server/grpc_protos:/ClickHouse/src/Server/grpc_protos         --volume=clickhouse_integration_tests_volume:/var/lib/docker  -e PYTEST_OPTS='test_fetch_partition_from_auxiliary_zookeeper' yandex/clickhouse-integration-tests-runner:latest





