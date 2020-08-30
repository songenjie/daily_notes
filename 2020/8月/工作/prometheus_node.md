```
global:
  scrape_interval:     1m  # Set the scrape interval to every 15 seconds. Default is every 1 minute.
  evaluation_interval: 1m  # Evaluate rules every 15 seconds. The default is every 1 minute.
  external_labels:
    prometheus:  172.21.216.34

scrape_configs:
- job_name: 'federate'

  honor_labels: true
  metrics_path: '/federate'


  params:
    'match[]':
      - '{__name__=~"up"}'                                                      #连通性
      - '{__name__=~"node_mode:node_cpu_seconds_total:irate5m_avg"}'            #cpu使用率5分钟
      - '{__name__=~"self_node_memory_used_bytes_percent"}'                     #内存使用率
      - '{__name__=~"node_load15"}'                                             #cpu负载15分钟
      - '{__name__=~"device:node_network_receive_bytes_total:irate5m"}'         #网络发送速率
      - '{__name__=~"-device:node_network_transmit_bytes_total:irate5m"}'       #网络接收速率
      - '{__name__=~"node_netstat_Tcp_CurrEstab"}'                              #TCP连接数
      - '{__name__=~"node_mount:self_node_filesystem_used_bytes:sum_percent"}'  #磁盘使用率
      - '{__name__=~"device:node_disk_read_bytes_total:irate5m"}'               #磁盘读 速率
      - '{__name__=~"device:node_disk_written_bytes_total:irate5m"}'            #磁盘写

  static_configs:
```

1. **获取节点信息****
   **接口：http://116.196.89.220:32090/api/v1/series?match[]=node_boot_time_seconds{job="node-exporter"}&start=1574147700&end=1574147700
   参数：
   　　start：开始时间戳
   　　end：结束时间戳

   

2. **集群信息查询**

   接口：http://116.196.89.220:32090/api/v1/query?query={}&time={}
   参数：
   　　query：prometheus表达式查询字符串
   　　time：某个时间点集群的信息
   　　

   查询时间步长，时间区间内每step执行一次

   

   获取各信息信息时query参数的值

   　　1). GPU各型号数量(对应grafana的Account of GPU第一行数据):
   　　　　count(container_accelerator_duty_cycle{pod_name =~ "nvidia-device-plugin.*",node=~".*"})by (model)
   　  2). GPU总数(对应grafana的Account of GPU第二行数据):
           count(container_accelerator_duty_cycle{pod_name =~ "nvidia-device-plugin.*",node=~".*"})
       3). GPU各型号已使用数量(对应grafana的Amount of Allocated GPUs第一行数据):
          count(container_accelerator_duty_cycle{image!="",pod_name!~".*device-plugin-daemonset.*",node=~".*"}) by (model)
   　  4). GPU已使用数量(对应grafana的Amount of Allocated GPUs第二行数据)
          count(container_accelerator_duty_cycle{image!="",pod_name!~".*device-plugin-daemonset.*",node=~".*"})
   　  5). GPU各型号可使用数量(对应grafana的Amount of Allocatable GPUs第一行数据)
           count(container_accelerator_duty_cycle{pod_name =~ "nvidia-device-plugin.*",node=~".*"})by (model)-count(container_accelerator_duty_cycle{image!="",pod_name!~".*device-plugin-daemonset.*",node=~".*"}) by (model)
       6). GPU可使用数量(对应grafana的Amount of Allocatable GPUs第二行数据)
           count(container_accelerator_duty_cycle{pod_name =~ "nvidia-device-plugin.*",node=~".*"}) - count(container_accelerator_duty_cycle{image!="",pod_name!~".*device-plugin-daemonset.*",node=~".*"})

   

3. **服务器监控**
   接口：http://116.196.89.220:32090/api/v1/query_range?query={}&start={}&end={}&step={}
   参数：
   　　query：prometheus表达式查询字符串
   　　start：开始时间戳
   　　end：结束时间戳
       step: 查询时间步长，时间区间内每step执行一次
   获取各监控数据时query参数的值
   　　1). 每个核的使用量(对应grafana的Usage Per Core):
   sum by (cpu) (irate(node_cpu_seconds_total{job="node-exporter", mode!="idle", instance="172.31.0.3:9100"}[5m]))
           说明：获取节点(172.31.0.3:9100)CPU各个核的使用量，如果去掉instance="172.31.0.3:9100"参数，则获取所有节点CPU各个核的使用量
   　  2).CPU最大使用量(对应grafana的CPU Utilization):
   max(sum by (cpu) (rate(node_cpu_seconds_total{job="node-exporter", mode!="idle", instance="172.31.0.3:9100"}[2m])))*100
         说明：获取节点(172.31.0.3:9100)CPU的最大使用量，如果去掉instance="172.31.0.3:9100"参数，则获取所有节点CPU的最大使用量
       3).CPU平均使用量(对应grafana的CPU Usage):
   avg(sum by (cpu) (rate(node_cpu_seconds_total{job="node-exporter", mode!="idle", instance="172.31.0.3:9100"}[2m])))*100
          说明：获取节点(172.31.0.3:9100)CPU的平均使用量，如果去掉instance="172.31.0.3:9100"参数，则获取所有节点CPU的平均使用量
   　  4).内存使用量(对应grafana的memory used)：总内存 - 未使用内存 - buffer容量 - cache容量
          max(node_memory_MemTotal_bytes{job="node-exporter", instance="172.31.0.3:9100"} 
              \- node_memory_MemFree_bytes{job="node-exporter", instance="172.31.0.3:9100"} 
              \- node_memory_Buffers_bytes{job="node-exporter", instance="172.31.0.3:9100"} 
              \- node_memory_Cached_bytes{job="node-exporter", instance="172.31.0.3:9100"})
          说明：获取节点(172.31.0.3:9100)内存使用量，如果去掉instance="172.31.0.3:9100"参数，则获取所有节点的内存使用量
   　  5). 内存使用率(对应grafana的memory usage)：(总内存 - 未使用内存 - buffer容量 - cache容量) / 总内存
           max((
               (node_memory_MemTotal_bytes{job="node-exporter", instance="172.31.0.3:9100"}
                \- node_memory_MemFree_bytes{job="node-exporter", instance="172.31.0.3:9100"}
                \- node_memory_Buffers_bytes{job="node-exporter", instance="172.31.0.3:9100"}
                \- node_memory_Cached_bytes{job="node-exporter", instance="172.31.0.3:9100"})
               / node_memory_MemTotal_bytes{job="node-exporter", instance="172.31.0.3:9100"}) * 100)
           说明：获取节点(172.31.0.3:9100)内存使用率，如果去掉instance="172.31.0.3:9100"参数，则获取所有节点的内存使用率
       6).系统1分钟内、5分钟内、15分钟内负载
   　　　　max(node_load1{job="node-exporter", instance="172.31.0.3:9100"})
   　　　　max(node_load1{job="node-exporter", instance="172.31.0.3:9100"})
   　　　　max(node_load1{job="node-exporter", instance="172.31.0.3:9100"})
   　　　　说明：获取节点(172.31.0.3:9100)各时间段内的负载，如果去掉instance="172.31.0.3:9100"参数，则获取所有节点的负载

      7). GPU使用率(对应grafana的Cluster GPU usage ratio)：
   　　　　sum(container_accelerator_duty_cycle{image!="",pod_name!~".*device-plugin-daemonset.*",node=~".*"})/count(container_accelerator_duty_cycle{pod_name =~ "nvidia-device-plugin.*"})

      8). GPU内存使用率(对应grafana的Cluster GPU memory usage)：
          sum(container_accelerator_memory_used_bytes{pod_name!~"nvidia-device-plugin.*",node=~".*"})/sum(container_accelerator_memory_total_bytes{pod_name=~"nvidia-device-plugin.*"})*100
   　 
      9). GPU内存使用量(对应grafana的Used)：
   　　　　sum(container_accelerator_memory_used_bytes{pod_name!~"nvidia-device-plugin.*"})

      10). GPU内存总量(对应grafana的Total)：
   　　　　sum(container_accelerator_memory_total_bytes{pod_name=~"nvidia-device-plugin.*"})

      11). 网络入流量(对应grafana的Network Received)：
   　　　　max(rate(node_network_receive_bytes_total{job="node-exporter", instance="172.31.0.3:9100", device!~"lo"}[5m]))
          说明：172.31.0.3:9100是通过第一个接口(获取节点信息)里instance字段的值，表示该节点

      10). 网络出流量(对应grafana的Network Transmitted)：
   　　　　max(rate(node_network_transmit_bytes_total{job="node-exporter", instance="172.31.0.3:9100", device!~"lo"}[5m]))
   　　　　说明：172.31.0.3:9100是通过第一个接口(获取节点信息)里instance字段的值，表示该节点

   