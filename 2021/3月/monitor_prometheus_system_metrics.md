(avg by (instance) (irate(node_cpu_seconds_total{mode="user", instance=~"$ipList"}[2m])) * 100) + (avg by (instance) (irate(node_cpu_seconds_total{mode="system", instance=~"$ipList"}[2m])) * 100)





```json
{
  "annotations": {
    "list": [
      {
        "builtIn": 1,
        "datasource": "-- Grafana --",
        "enable": true,
        "hide": true,
        "iconColor": "rgba(0, 211, 255, 1)",
        "name": "Annotations & Alerts",
        "type": "dashboard"
      }
    ]
  },
  "editable": true,
  "gnetId": null,
  "graphTooltip": 0,
  "id": 183,
  "iteration": 1614591163771,
  "links": [],
  "panels": [
    {
      "collapsed": true,
      "datasource": null,
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 0
      },
      "id": 62,
      "panels": [
        {
          "datasource": "Prometheus-baize-olap",
          "gridPos": {
            "h": 5,
            "w": 6,
            "x": 0,
            "y": 1
          },
          "id": 48,
          "options": {
            "fieldOptions": {
              "calcs": [
                "last"
              ],
              "defaults": {
                "mappings": [
                  {
                    "from": "",
                    "id": 1,
                    "operator": "",
                    "text": "",
                    "to": "",
                    "type": 1,
                    "value": ""
                  }
                ],
                "max": 100,
                "min": 0,
                "thresholds": [
                  {
                    "color": "green",
                    "value": null
                  },
                  {
                    "color": "#EAB839",
                    "value": 50
                  },
                  {
                    "color": "red",
                    "value": 75
                  }
                ]
              },
              "override": {},
              "values": false
            },
            "orientation": "auto",
            "showThresholdLabels": false,
            "showThresholdMarkers": true
          },
          "pluginVersion": "6.5.2",
          "targets": [
            {
              "expr": "max (avg by (instance) (irate(node_cpu_seconds_total{mode=~\"user\", instance=~\"$ipList\"}[2m])) * 100) + max(avg by (instance) (irate(node_cpu_seconds_total{mode=~\"system\", instance=~\"$ipList\"}[2m])) * 100)",
              "hide": false,
              "legendFormat": "",
              "refId": "A"
            },
            {
              "expr": "",
              "legendFormat": "",
              "refId": "B"
            }
          ],
          "timeFrom": null,
          "timeShift": null,
          "title": "CPU利用率",
          "type": "gauge"
        },
        {
          "datasource": "Prometheus-baize-olap",
          "gridPos": {
            "h": 5,
            "w": 6,
            "x": 6,
            "y": 1
          },
          "id": 50,
          "options": {
            "fieldOptions": {
              "calcs": [
                "last"
              ],
              "defaults": {
                "mappings": [],
                "max": 100,
                "min": 0,
                "thresholds": [
                  {
                    "color": "green",
                    "value": null
                  },
                  {
                    "color": "#EAB839",
                    "value": 50
                  },
                  {
                    "color": "red",
                    "value": 75
                  }
                ]
              },
              "override": {},
              "values": false
            },
            "orientation": "auto",
            "showThresholdLabels": false,
            "showThresholdMarkers": true
          },
          "pluginVersion": "6.5.2",
          "targets": [
            {
              "expr": "avg( (1 - node_memory_MemAvailable_bytes{instance=~\"$ipList\"}/node_memory_MemTotal_bytes{instance=~\"$ipList\"}) * 100 )",
              "refId": "A"
            }
          ],
          "timeFrom": null,
          "timeShift": null,
          "title": "内存利用率",
          "type": "gauge"
        },
        {
          "datasource": "Prometheus-baize-olap",
          "gridPos": {
            "h": 5,
            "w": 6,
            "x": 12,
            "y": 1
          },
          "id": 54,
          "options": {
            "fieldOptions": {
              "calcs": [
                "last"
              ],
              "defaults": {
                "mappings": [],
                "max": 100,
                "min": 0,
                "thresholds": [
                  {
                    "color": "green",
                    "value": null
                  },
                  {
                    "color": "#EAB839",
                    "value": 50
                  },
                  {
                    "color": "red",
                    "value": 75
                  }
                ]
              },
              "override": {},
              "values": false
            },
            "orientation": "auto",
            "showThresholdLabels": false,
            "showThresholdMarkers": true
          },
          "pluginVersion": "6.5.2",
          "targets": [
            {
              "expr": "max( rate(node_disk_io_time_seconds_total{instance=~\"$ipList\", device=~\"sd.*|nvme.*\"}[2m])*100 )",
              "refId": "A"
            }
          ],
          "timeFrom": null,
          "timeShift": null,
          "title": "磁盘繁忙",
          "type": "gauge"
        },
        {
          "datasource": "Prometheus-baize-olap",
          "gridPos": {
            "h": 5,
            "w": 6,
            "x": 18,
            "y": 1
          },
          "id": 52,
          "options": {
            "fieldOptions": {
              "calcs": [
                "last"
              ],
              "defaults": {
                "mappings": [],
                "max": 100,
                "min": 0,
                "thresholds": [
                  {
                    "color": "green",
                    "value": null
                  },
                  {
                    "color": "#EAB839",
                    "value": 50
                  },
                  {
                    "color": "red",
                    "value": 75
                  }
                ]
              },
              "override": {},
              "values": false
            },
            "orientation": "auto",
            "showThresholdLabels": false,
            "showThresholdMarkers": true
          },
          "pluginVersion": "6.5.2",
          "targets": [
            {
              "expr": "max( (1 - node_filesystem_avail_bytes{instance=~\"$ipList\", device=~\"^/dev/.*\"} / node_filesystem_size_bytes{instance=~\"$ipList\", device=~\"^/dev/.*\"}) * 100 )",
              "refId": "A"
            }
          ],
          "timeFrom": null,
          "timeShift": null,
          "title": "磁盘使用率",
          "type": "gauge"
        },
        {
          "aliasColors": {},
          "bars": false,
          "cacheTimeout": null,
          "dashLength": 10,
          "dashes": false,
          "datasource": "Prometheus-baize-olap",
          "fill": 1,
          "fillGradient": 0,
          "gridPos": {
            "h": 7,
            "w": 12,
            "x": 0,
            "y": 6
          },
          "hiddenSeries": false,
          "id": 56,
          "legend": {
            "alignAsTable": false,
            "avg": false,
            "current": false,
            "max": false,
            "min": false,
            "show": true,
            "total": false,
            "values": false
          },
          "lines": true,
          "linewidth": 2,
          "links": [],
          "nullPointMode": "null",
          "options": {
            "dataLinks": []
          },
          "percentage": false,
          "pluginVersion": "6.5.2",
          "pointradius": 2,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "expr": "sum(rate(node_disk_written_bytes_total{instance=~\"$ipList\", device=~\"sd.*|nvme.*\"}[2m]))",
              "instant": false,
              "intervalFactor": 1,
              "legendFormat": "总写入",
              "refId": "B"
            },
            {
              "expr": "max(rate(node_disk_written_bytes_total{instance=~\"$ipList\", device=~\"sd.*|nvme.*\"}[2m]))",
              "intervalFactor": 1,
              "legendFormat": "最大写入",
              "refId": "C"
            },
            {
              "expr": "avg(rate(node_disk_written_bytes_total{instance=~\"$ipList\", device=~\"sd.*|nvme.*\"}[2m]))",
              "format": "time_series",
              "instant": false,
              "intervalFactor": 1,
              "legendFormat": "平均写入",
              "refId": "A"
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeRegions": [],
          "timeShift": null,
          "title": "磁盘写入速度",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "buckets": null,
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "decbytes",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "decimals": null,
              "format": "decbytes",
              "label": "",
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ],
          "yaxis": {
            "align": false,
            "alignLevel": null
          }
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": "Prometheus-baize-olap",
          "fill": 1,
          "fillGradient": 0,
          "gridPos": {
            "h": 7,
            "w": 12,
            "x": 12,
            "y": 6
          },
          "hiddenSeries": false,
          "id": 58,
          "legend": {
            "avg": false,
            "current": false,
            "max": false,
            "min": false,
            "show": true,
            "total": false,
            "values": false
          },
          "lines": true,
          "linewidth": 2,
          "nullPointMode": "null",
          "options": {
            "dataLinks": []
          },
          "percentage": false,
          "pointradius": 2,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "expr": "sum( rate(node_disk_read_bytes_total{instance=~\"$ipList\", device=~\"sd.*|nvme.*\"}[2m]) )",
              "legendFormat": "总读取",
              "refId": "B"
            },
            {
              "expr": "max( rate(node_disk_read_bytes_total{instance=~\"$ipList\", device=~\"sd.*|nvme.*\"}[2m]) )",
              "legendFormat": "最大读取",
              "refId": "C"
            },
            {
              "expr": "avg( rate(node_disk_read_bytes_total{instance=~\"$ipList\", device=~\"sd.*|nvme.*\"}[2m]) )",
              "legendFormat": "平均读取",
              "refId": "A"
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeRegions": [],
          "timeShift": null,
          "title": "磁盘读取速度",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "buckets": null,
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "decbytes",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ],
          "yaxis": {
            "align": false,
            "alignLevel": null
          }
        }
      ],
      "title": "系统概览",
      "type": "row"
    },
    {
      "collapsed": false,
      "datasource": null,
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 1
      },
      "id": 44,
      "panels": [],
      "title": "CPU和内存",
      "type": "row"
    },
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": "Prometheus-baize-olap",
      "description": "",
      "fieldConfig": {
        "defaults": {
          "custom": {},
          "links": [
            {
              "title": "",
              "url": "http://mdc.jd.com/monitor/chart?ip=11.11.1.232"
            }
          ]
        },
        "overrides": []
      },
      "fill": 1,
      "fillGradient": 0,
      "gridPos": {
        "h": 8,
        "w": 12,
        "x": 0,
        "y": 2
      },
      "hiddenSeries": false,
      "id": 14,
      "legend": {
        "alignAsTable": true,
        "avg": true,
        "current": true,
        "max": true,
        "min": true,
        "rightSide": false,
        "show": true,
        "sort": null,
        "sortDesc": null,
        "total": false,
        "values": true
      },
      "lines": true,
      "linewidth": 1,
      "links": [],
      "nullPointMode": "null",
      "options": {
        "alertThreshold": true
      },
      "percentage": false,
      "pluginVersion": "7.3.2",
      "pointradius": 2,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "expr": "(avg by (instance) (irate(node_cpu_seconds_total{mode=\"user\", instance=~\"$ipList\"}[2m])) * 100) + (avg by (instance) (irate(node_cpu_seconds_total{mode=\"system\", instance=~\"$ipList\"}[2m])) * 100)",
          "hide": false,
          "legendFormat": "{{instance}}-usr+sys",
          "refId": "A"
        },
        {
          "expr": "100-(avg by (instance) (irate(node_cpu_seconds_total{mode=\"idle\", instance=~\"$ipList\"}[2m])) * 100)",
          "hide": true,
          "legendFormat": "{{instance}}-idle",
          "refId": "B"
        }
      ],
      "thresholds": [],
      "timeFrom": null,
      "timeRegions": [],
      "timeShift": null,
      "title": "CPU使用率（2m）",
      "tooltip": {
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "buckets": null,
        "mode": "time",
        "name": null,
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "percent",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        },
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": false
        }
      ],
      "yaxis": {
        "align": false,
        "alignLevel": null
      }
    },
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": "Prometheus-baize-olap",
      "decimals": null,
      "description": "",
      "fieldConfig": {
        "defaults": {
          "custom": {
            "align": null
          },
          "links": [],
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          }
        },
        "overrides": []
      },
      "fill": 1,
      "fillGradient": 0,
      "gridPos": {
        "h": 8,
        "w": 12,
        "x": 12,
        "y": 2
      },
      "hiddenSeries": false,
      "id": 12,
      "legend": {
        "alignAsTable": true,
        "avg": true,
        "current": true,
        "max": true,
        "min": true,
        "show": true,
        "sort": "max",
        "sortDesc": true,
        "total": false,
        "values": true
      },
      "lines": true,
      "linewidth": 1,
      "nullPointMode": "null",
      "options": {
        "alertThreshold": true
      },
      "percentage": false,
      "pluginVersion": "7.3.2",
      "pointradius": 2,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "expr": "(1 - node_memory_MemAvailable_bytes{instance=~\"$ipList\"}/node_memory_MemTotal_bytes{instance=~\"$ipList\"}) * 100",
          "interval": "",
          "legendFormat": "{{instance}}",
          "refId": "B"
        }
      ],
      "thresholds": [],
      "timeFrom": null,
      "timeRegions": [],
      "timeShift": null,
      "title": "内存使用率",
      "tooltip": {
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "buckets": null,
        "mode": "time",
        "name": null,
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "percent",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        },
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        }
      ],
      "yaxis": {
        "align": false,
        "alignLevel": null
      }
    },
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": "Prometheus-baize-olap",
      "fieldConfig": {
        "defaults": {
          "custom": {},
          "links": []
        },
        "overrides": []
      },
      "fill": 1,
      "fillGradient": 0,
      "gridPos": {
        "h": 8,
        "w": 12,
        "x": 0,
        "y": 10
      },
      "hiddenSeries": false,
      "id": 8,
      "legend": {
        "alignAsTable": true,
        "avg": true,
        "current": true,
        "max": true,
        "min": true,
        "rightSide": false,
        "show": true,
        "sort": "max",
        "sortDesc": true,
        "total": false,
        "values": true
      },
      "lines": true,
      "linewidth": 1,
      "nullPointMode": "null",
      "options": {
        "alertThreshold": true
      },
      "percentage": false,
      "pluginVersion": "7.3.2",
      "pointradius": 2,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "expr": "node_load1{instance=~\"$ipList\"}",
          "interval": "",
          "legendFormat": "load1-{{instance}}",
          "refId": "A"
        },
        {
          "expr": "node_load5{instance=~\"$ipList\"}",
          "hide": true,
          "interval": "",
          "legendFormat": "{{instance}}-{{__name__}}",
          "refId": "B"
        },
        {
          "expr": "node_load15{instance=~\"$ipList\"}",
          "hide": true,
          "interval": "",
          "legendFormat": "{{instance}}-{{__name__}}",
          "refId": "C"
        }
      ],
      "thresholds": [],
      "timeFrom": null,
      "timeRegions": [],
      "timeShift": null,
      "title": "Load Average",
      "tooltip": {
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "buckets": null,
        "mode": "time",
        "name": null,
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        },
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        }
      ],
      "yaxis": {
        "align": false,
        "alignLevel": null
      }
    },
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": "Prometheus-baize-olap",
      "fieldConfig": {
        "defaults": {
          "custom": {},
          "links": []
        },
        "overrides": []
      },
      "fill": 1,
      "fillGradient": 0,
      "gridPos": {
        "h": 8,
        "w": 12,
        "x": 12,
        "y": 10
      },
      "hiddenSeries": false,
      "id": 22,
      "legend": {
        "alignAsTable": true,
        "avg": true,
        "current": true,
        "max": true,
        "min": true,
        "show": true,
        "sort": "max",
        "sortDesc": true,
        "total": false,
        "values": true
      },
      "lines": true,
      "linewidth": 1,
      "nullPointMode": "null",
      "options": {
        "alertThreshold": true
      },
      "percentage": false,
      "pluginVersion": "7.3.2",
      "pointradius": 2,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "expr": "rate(node_context_switches_total{instance=~\"$ipList\"}[2m])",
          "interval": "",
          "legendFormat": "{{instance}}",
          "refId": "A"
        }
      ],
      "thresholds": [],
      "timeFrom": null,
      "timeRegions": [],
      "timeShift": null,
      "title": "Context Switches(2m)",
      "tooltip": {
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "buckets": null,
        "mode": "time",
        "name": null,
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        },
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        }
      ],
      "yaxis": {
        "align": false,
        "alignLevel": null
      }
    },
    {
      "collapsed": true,
      "datasource": null,
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 18
      },
      "id": 60,
      "panels": [
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": "Prometheus-baize-olap",
          "fieldConfig": {
            "defaults": {
              "custom": {}
            },
            "overrides": []
          },
          "fill": 1,
          "fillGradient": 0,
          "gridPos": {
            "h": 9,
            "w": 8,
            "x": 0,
            "y": 3
          },
          "hiddenSeries": false,
          "id": 16,
          "legend": {
            "alignAsTable": true,
            "avg": true,
            "current": true,
            "max": true,
            "min": true,
            "show": true,
            "sort": "max",
            "sortDesc": true,
            "total": false,
            "values": true
          },
          "lines": true,
          "linewidth": 1,
          "nullPointMode": "null",
          "options": {
            "dataLinks": []
          },
          "percentage": false,
          "pointradius": 2,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "expr": "rate(node_disk_io_time_seconds_total{instance=~\"$ipList\"}[5m])*100",
              "interval": "",
              "legendFormat": "{{instance}}-{{device}}",
              "refId": "A"
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeRegions": [],
          "timeShift": null,
          "title": "IO_util",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "buckets": null,
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "percent",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ],
          "yaxis": {
            "align": false,
            "alignLevel": null
          }
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": "Prometheus-baize-olap",
          "fieldConfig": {
            "defaults": {
              "custom": {}
            },
            "overrides": []
          },
          "fill": 1,
          "fillGradient": 0,
          "gridPos": {
            "h": 9,
            "w": 8,
            "x": 8,
            "y": 3
          },
          "hiddenSeries": false,
          "id": 6,
          "legend": {
            "alignAsTable": true,
            "avg": true,
            "current": true,
            "max": true,
            "min": true,
            "show": true,
            "sort": "max",
            "sortDesc": true,
            "total": false,
            "values": true
          },
          "lines": true,
          "linewidth": 1,
          "nullPointMode": "null",
          "options": {
            "dataLinks": []
          },
          "percentage": false,
          "pointradius": 2,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "expr": "rate(node_disk_written_bytes_total{instance=~\"$ipList\", device=~\"sd.*|nvme.*\"}[5m])",
              "interval": "",
              "legendFormat": "{{instance}}-{{device}}",
              "refId": "A"
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeRegions": [],
          "timeShift": null,
          "title": "written_bytes/s",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "buckets": null,
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "bytes",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ],
          "yaxis": {
            "align": false,
            "alignLevel": null
          }
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": "Prometheus-baize-olap",
          "description": "",
          "fieldConfig": {
            "defaults": {
              "custom": {}
            },
            "overrides": []
          },
          "fill": 1,
          "fillGradient": 0,
          "gridPos": {
            "h": 9,
            "w": 8,
            "x": 16,
            "y": 3
          },
          "hiddenSeries": false,
          "id": 4,
          "legend": {
            "alignAsTable": true,
            "avg": true,
            "current": true,
            "max": true,
            "min": true,
            "show": true,
            "sort": "max",
            "sortDesc": true,
            "total": false,
            "values": true
          },
          "lines": true,
          "linewidth": 1,
          "nullPointMode": "null",
          "options": {
            "dataLinks": []
          },
          "percentage": false,
          "pointradius": 2,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "expr": "rate(node_disk_read_bytes_total{instance=~\"$ipList\", device=~\"sd.*|nvme.*\"}[5m])",
              "interval": "",
              "legendFormat": "{{instance}}-{{device}}",
              "refId": "A"
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeRegions": [],
          "timeShift": null,
          "title": "read_bytes/s",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "buckets": null,
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "bytes",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ],
          "yaxis": {
            "align": false,
            "alignLevel": null
          }
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": "Prometheus-baize-olap",
          "fieldConfig": {
            "defaults": {
              "custom": {}
            },
            "overrides": []
          },
          "fill": 1,
          "fillGradient": 0,
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 0,
            "y": 12
          },
          "hiddenSeries": false,
          "id": 24,
          "legend": {
            "alignAsTable": true,
            "avg": true,
            "current": true,
            "max": true,
            "min": true,
            "show": true,
            "sort": "max",
            "sortDesc": true,
            "total": false,
            "values": true
          },
          "lines": true,
          "linewidth": 1,
          "nullPointMode": "null",
          "options": {
            "dataLinks": []
          },
          "percentage": false,
          "pointradius": 2,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "expr": "rate(node_disk_writes_completed_total{instance=~\"$ipList\"}[5m])",
              "interval": "",
              "legendFormat": "{{instance}}-{{device}}",
              "refId": "A"
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeRegions": [],
          "timeShift": null,
          "title": "writes_completed",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "buckets": null,
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ],
          "yaxis": {
            "align": false,
            "alignLevel": null
          }
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": "Prometheus-baize-olap",
          "fieldConfig": {
            "defaults": {
              "custom": {}
            },
            "overrides": []
          },
          "fill": 1,
          "fillGradient": 0,
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 12,
            "y": 12
          },
          "hiddenSeries": false,
          "id": 26,
          "legend": {
            "alignAsTable": true,
            "avg": true,
            "current": true,
            "max": true,
            "min": true,
            "show": true,
            "sort": "max",
            "sortDesc": false,
            "total": false,
            "values": true
          },
          "lines": true,
          "linewidth": 1,
          "nullPointMode": "null",
          "options": {
            "dataLinks": []
          },
          "percentage": false,
          "pointradius": 2,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "expr": "rate(node_disk_reads_completed_total{instance=~\"$ipList\", device=~\"sd.*|nvme.*\"}[5m])",
              "interval": "",
              "legendFormat": "{{instance}}-{{device}}",
              "refId": "A"
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeRegions": [],
          "timeShift": null,
          "title": "reads_completed",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "buckets": null,
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ],
          "yaxis": {
            "align": false,
            "alignLevel": null
          }
        }
      ],
      "title": "磁盘实时",
      "type": "row"
    },
    {
      "collapsed": true,
      "datasource": null,
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 19
      },
      "id": 42,
      "panels": [
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": "Prometheus-baize-olap",
          "fill": 1,
          "fillGradient": 0,
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 0,
            "y": 4
          },
          "hiddenSeries": false,
          "id": 38,
          "legend": {
            "alignAsTable": true,
            "avg": true,
            "current": true,
            "max": true,
            "min": false,
            "show": true,
            "sort": null,
            "sortDesc": null,
            "total": false,
            "values": true
          },
          "lines": true,
          "linewidth": 1,
          "nullPointMode": "null",
          "options": {
            "dataLinks": []
          },
          "percentage": false,
          "pointradius": 2,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "expr": "(1 - node_filesystem_avail_bytes{instance=~\"$ipList\", device=~\"^/dev/.*\"}/node_filesystem_size_bytes{instance=~\"$ipList\", device=~\"^/dev/.*\"}) * 100",
              "legendFormat": "{{instance}}-{{mountpoint}}",
              "refId": "A"
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeRegions": [],
          "timeShift": null,
          "title": "磁盘使用率-all",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "buckets": null,
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ],
          "yaxis": {
            "align": false,
            "alignLevel": null
          }
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": "Prometheus-baize-olap",
          "fieldConfig": {
            "defaults": {
              "custom": {}
            },
            "overrides": []
          },
          "fill": 1,
          "fillGradient": 0,
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 12,
            "y": 4
          },
          "hiddenSeries": false,
          "id": 30,
          "legend": {
            "alignAsTable": true,
            "avg": true,
            "current": true,
            "max": true,
            "min": true,
            "show": true,
            "sort": "current",
            "sortDesc": true,
            "total": false,
            "values": true
          },
          "lines": true,
          "linewidth": 1,
          "nullPointMode": "null",
          "options": {
            "dataLinks": []
          },
          "percentage": false,
          "pointradius": 2,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "expr": "(1 - node_filesystem_avail_bytes{instance=~\"$ipList\", mountpoint=~\"/data[0-11]+\"}/node_filesystem_size_bytes{instance=~\"$ipList\", mountpoint=~\"/data[0-11]+\"}) * 100",
              "interval": "",
              "legendFormat": "{{instance}}-{{mountpoint}}",
              "refId": "A"
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeRegions": [],
          "timeShift": null,
          "title": "磁盘使用率",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "buckets": null,
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ],
          "yaxis": {
            "align": false,
            "alignLevel": null
          }
        },
        {
          "alert": {
            "alertRuleTags": {},
            "conditions": [
              {
                "evaluator": {
                  "params": [
                    80
                  ],
                  "type": "gt"
                },
                "operator": {
                  "type": "and"
                },
                "query": {
                  "params": [
                    "A",
                    "5m",
                    "now"
                  ]
                },
                "reducer": {
                  "params": [],
                  "type": "avg"
                },
                "type": "query"
              }
            ],
            "executionErrorState": "alerting",
            "for": "5m",
            "frequency": "1m",
            "handler": 1,
            "message": "inode 80%",
            "name": "inode使用率 alert",
            "noDataState": "no_data",
            "notifications": []
          },
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": "Prometheus-baize-olap",
          "fieldConfig": {
            "defaults": {
              "custom": {}
            },
            "overrides": []
          },
          "fill": 1,
          "fillGradient": 0,
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 0,
            "y": 12
          },
          "hiddenSeries": false,
          "id": 32,
          "legend": {
            "alignAsTable": true,
            "avg": true,
            "current": true,
            "max": true,
            "min": true,
            "rightSide": false,
            "show": true,
            "sort": "current",
            "sortDesc": true,
            "total": false,
            "values": true
          },
          "lines": true,
          "linewidth": 1,
          "nullPointMode": "null",
          "options": {
            "dataLinks": []
          },
          "percentage": false,
          "pointradius": 2,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "expr": "(1 - (node_filesystem_files_free{instance=~\"$ipList\", device=~\"^/dev/sd.*|^/dev/nvme.*\"} / node_filesystem_files{instance=~\"$ipList\", device=~\"^/dev/sd.*|^/dev/nvme.*\"})) * 100",
              "hide": false,
              "interval": "",
              "legendFormat": "{{instance}}-{{mountpoint}}",
              "refId": "A"
            }
          ],
          "thresholds": [
            {
              "colorMode": "critical",
              "fill": true,
              "line": true,
              "op": "gt",
              "value": 80,
              "yaxis": "left"
            }
          ],
          "timeFrom": null,
          "timeRegions": [],
          "timeShift": null,
          "title": "inode使用率",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "buckets": null,
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "percent",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ],
          "yaxis": {
            "align": false,
            "alignLevel": null
          }
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": "Prometheus-baize-olap",
          "fieldConfig": {
            "defaults": {
              "custom": {}
            },
            "overrides": []
          },
          "fill": 1,
          "fillGradient": 0,
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 12,
            "y": 12
          },
          "hiddenSeries": false,
          "id": 36,
          "legend": {
            "alignAsTable": true,
            "avg": true,
            "current": true,
            "max": true,
            "min": true,
            "show": true,
            "total": false,
            "values": true
          },
          "lines": true,
          "linewidth": 1,
          "nullPointMode": "null",
          "options": {
            "dataLinks": []
          },
          "percentage": false,
          "pointradius": 2,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "expr": "node_filefd_allocated{instance=~\"$ipList\"} / node_filefd_maximum{instance=~\"$ipList\"} * 100",
              "hide": false,
              "interval": "",
              "legendFormat": "{{instance}}",
              "refId": "A"
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeRegions": [],
          "timeShift": null,
          "title": "filefd使用率",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "buckets": null,
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "percent",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ],
          "yaxis": {
            "align": false,
            "alignLevel": null
          }
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": "Prometheus-baize-olap",
          "fieldConfig": {
            "defaults": {
              "custom": {}
            },
            "overrides": []
          },
          "fill": 1,
          "fillGradient": 0,
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 0,
            "y": 20
          },
          "hiddenSeries": false,
          "id": 34,
          "legend": {
            "alignAsTable": true,
            "avg": true,
            "current": true,
            "max": true,
            "min": true,
            "show": true,
            "total": false,
            "values": true
          },
          "lines": true,
          "linewidth": 1,
          "nullPointMode": "null",
          "options": {
            "dataLinks": []
          },
          "percentage": false,
          "pointradius": 2,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "expr": "node_filesystem_readonly{instance=~\"$ipList\", device=~\"^/dev/sd.*|^/dev/nvme.*\"}",
              "interval": "",
              "legendFormat": "{{instance}}-{{device}}-readonly",
              "refId": "A"
            },
            {
              "expr": "node_filesystem_device_error{instance=~\"$ipList\", device=~\"^/dev/sd.*|^/dev/nvme.*\"}",
              "interval": "",
              "legendFormat": "{{instance}}-{{device}}-error",
              "refId": "B"
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeRegions": [],
          "timeShift": null,
          "title": "磁盘错误",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "buckets": null,
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ],
          "yaxis": {
            "align": false,
            "alignLevel": null
          }
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": "Prometheus-baize-olap",
          "fieldConfig": {
            "defaults": {
              "custom": {}
            },
            "overrides": []
          },
          "fill": 1,
          "fillGradient": 0,
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 12,
            "y": 20
          },
          "hiddenSeries": false,
          "id": 28,
          "legend": {
            "alignAsTable": true,
            "avg": true,
            "current": true,
            "max": true,
            "min": true,
            "show": true,
            "total": false,
            "values": true
          },
          "lines": true,
          "linewidth": 1,
          "nullPointMode": "null",
          "options": {
            "dataLinks": []
          },
          "percentage": false,
          "pointradius": 2,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "expr": "node_memory_SwapTotal_bytes{instance=~\"$ipList\"}",
              "interval": "",
              "legendFormat": "{{instance}}",
              "refId": "A"
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeRegions": [],
          "timeShift": null,
          "title": "Swap",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "buckets": null,
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ],
          "yaxis": {
            "align": false,
            "alignLevel": null
          }
        }
      ],
      "title": "磁盘容量",
      "type": "row"
    },
    {
      "collapsed": true,
      "datasource": null,
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 20
      },
      "id": 40,
      "panels": [
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": "Prometheus-baize-olap",
          "fieldConfig": {
            "defaults": {
              "custom": {}
            },
            "overrides": []
          },
          "fill": 1,
          "fillGradient": 0,
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 0,
            "y": 5
          },
          "hiddenSeries": false,
          "id": 20,
          "legend": {
            "alignAsTable": true,
            "avg": true,
            "current": true,
            "max": true,
            "min": true,
            "show": true,
            "sort": "max",
            "sortDesc": true,
            "total": false,
            "values": true
          },
          "lines": true,
          "linewidth": 1,
          "nullPointMode": "null",
          "options": {
            "dataLinks": []
          },
          "percentage": false,
          "pointradius": 2,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "expr": "rate(node_network_receive_bytes_total{device=~\"eth0|bond0\", instance=~\"$ipList\"}[5m])",
              "interval": "",
              "legendFormat": "{{instance}}-{{device}}",
              "refId": "A"
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeRegions": [],
          "timeShift": null,
          "title": "network_receive_bytes/s",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "buckets": null,
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "bytes",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ],
          "yaxis": {
            "align": false,
            "alignLevel": null
          }
        },
        {
          "aliasColors": {},
          "bars": false,
          "dashLength": 10,
          "dashes": false,
          "datasource": "Prometheus-baize-olap",
          "fieldConfig": {
            "defaults": {
              "custom": {}
            },
            "overrides": []
          },
          "fill": 1,
          "fillGradient": 0,
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 12,
            "y": 5
          },
          "hiddenSeries": false,
          "id": 18,
          "legend": {
            "alignAsTable": true,
            "avg": true,
            "current": true,
            "max": true,
            "min": true,
            "show": true,
            "sort": "max",
            "sortDesc": true,
            "total": false,
            "values": true
          },
          "lines": true,
          "linewidth": 1,
          "nullPointMode": "null",
          "options": {
            "dataLinks": []
          },
          "percentage": false,
          "pointradius": 2,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "spaceLength": 10,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "expr": "rate(node_network_transmit_bytes_total{device=~\"eth0|bond0\", instance=~\"$ipList\"}[5m])",
              "interval": "",
              "legendFormat": "{{instance}}-{{device}}",
              "refId": "A"
            }
          ],
          "thresholds": [],
          "timeFrom": null,
          "timeRegions": [],
          "timeShift": null,
          "title": "network_transmit_bytes/s",
          "tooltip": {
            "shared": true,
            "sort": 0,
            "value_type": "individual"
          },
          "type": "graph",
          "xaxis": {
            "buckets": null,
            "mode": "time",
            "name": null,
            "show": true,
            "values": []
          },
          "yaxes": [
            {
              "format": "bytes",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            },
            {
              "format": "short",
              "label": null,
              "logBase": 1,
              "max": null,
              "min": null,
              "show": true
            }
          ],
          "yaxis": {
            "align": false,
            "alignLevel": null
          }
        }
      ],
      "title": "网络",
      "type": "row"
    }
  ],
  "refresh": "1m",
  "schemaVersion": 26,
  "style": "dark",
  "tags": [
    "system",
    "clickhouse"
  ],
  "templating": {
    "list": [
      {
        "allValue": "${clusterall}",
        "current": {
          "selected": true,
          "text": "LF0_CK_Pub_21",
          "value": "LF0_CK_Pub_21"
        },
        "datasource": "MySQL_kunpeng",
        "definition": "select tag from (select distinct tag_value tag from bz_ops_ips where tag_key = 'cluster' and ip_num in (select t1.ip_num  from ((select * from bz_ops_ips where tag_key='product' and tag_value='olap') t1 join (select * from bz_ops_ips where tag_key='deploymentServices' and tag_value='clickhouse')t2 on t1.ip=t2.ip))) t3 order by tag",
        "error": null,
        "hide": 0,
        "includeAll": false,
        "label": null,
        "multi": false,
        "name": "cluster",
        "options": [],
        "query": "select tag from (select distinct tag_value tag from bz_ops_ips where tag_key = 'cluster' and ip_num in (select t1.ip_num  from ((select * from bz_ops_ips where tag_key='product' and tag_value='olap') t1 join (select * from bz_ops_ips where tag_key='deploymentServices' and tag_value='clickhouse')t2 on t1.ip=t2.ip))) t3 order by tag",
        "refresh": 1,
        "regex": "",
        "skipUrlSync": false,
        "sort": 0,
        "tagValuesQuery": "",
        "tags": [],
        "tagsQuery": "",
        "type": "query",
        "useTags": false
      },
      {
        "allValue": null,
        "current": {
          "selected": false,
          "text": "10.203.26.121|10.203.26.122|10.203.26.123|10.203.26.130|10.203.26.131|10.203.26.132|10.203.26.133|10.203.26.134|10.203.26.135|10.203.26.136|10.203.26.137|10.203.26.138|10.203.26.139|10.203.26.146|10.203.26.147|10.203.26.148|10.203.26.149|10.203.26.150|10.203.26.151|10.203.26.152|10.203.26.153|10.203.26.154|10.203.26.155|10.203.26.162|10.203.26.163|10.203.26.164|10.203.26.165|10.203.26.166|10.203.26.167|10.203.26.168|10.203.26.169|10.203.26.178|10.203.26.179|10.203.26.180|10.203.26.181|10.203.26.182|10.203.26.183|10.203.26.184|10.203.26.185|10.203.26.195|10.203.26.196|10.203.26.197|10.203.26.198|10.203.26.199|10.203.26.200",
          "value": "10.203.26.121|10.203.26.122|10.203.26.123|10.203.26.130|10.203.26.131|10.203.26.132|10.203.26.133|10.203.26.134|10.203.26.135|10.203.26.136|10.203.26.137|10.203.26.138|10.203.26.139|10.203.26.146|10.203.26.147|10.203.26.148|10.203.26.149|10.203.26.150|10.203.26.151|10.203.26.152|10.203.26.153|10.203.26.154|10.203.26.155|10.203.26.162|10.203.26.163|10.203.26.164|10.203.26.165|10.203.26.166|10.203.26.167|10.203.26.168|10.203.26.169|10.203.26.178|10.203.26.179|10.203.26.180|10.203.26.181|10.203.26.182|10.203.26.183|10.203.26.184|10.203.26.185|10.203.26.195|10.203.26.196|10.203.26.197|10.203.26.198|10.203.26.199|10.203.26.200"
        },
        "datasource": "MySQL_kunpeng",
        "definition": "select  group_concat(t1.ip SEPARATOR \"|\") from ((select * from bz_ops_ips where tag_key='product' and tag_value='olap') t1  join (select * from bz_ops_ips where tag_key='deploymentServices' and tag_value='clickhouse')t2 on t1.ip=t2.ip ) \njoin (select * from bz_ops_ips where  tag_key='cluster' and `tag_value` = '$cluster')t3  on t1.ip = t3.ip",
        "error": null,
        "hide": 2,
        "includeAll": false,
        "label": "",
        "multi": false,
        "name": "ipList",
        "options": [
          {
            "selected": true,
            "text": "10.203.26.121|10.203.26.122|10.203.26.123|10.203.26.130|10.203.26.131|10.203.26.132|10.203.26.133|10.203.26.134|10.203.26.135|10.203.26.136|10.203.26.137|10.203.26.138|10.203.26.139|10.203.26.146|10.203.26.147|10.203.26.148|10.203.26.149|10.203.26.150|10.203.26.151|10.203.26.152|10.203.26.153|10.203.26.154|10.203.26.155|10.203.26.162|10.203.26.163|10.203.26.164|10.203.26.165|10.203.26.166|10.203.26.167|10.203.26.168|10.203.26.169|10.203.26.178|10.203.26.179|10.203.26.180|10.203.26.181|10.203.26.182|10.203.26.183|10.203.26.184|10.203.26.185|10.203.26.195|10.203.26.196|10.203.26.197|10.203.26.198|10.203.26.199|10.203.26.200",
            "value": "10.203.26.121|10.203.26.122|10.203.26.123|10.203.26.130|10.203.26.131|10.203.26.132|10.203.26.133|10.203.26.134|10.203.26.135|10.203.26.136|10.203.26.137|10.203.26.138|10.203.26.139|10.203.26.146|10.203.26.147|10.203.26.148|10.203.26.149|10.203.26.150|10.203.26.151|10.203.26.152|10.203.26.153|10.203.26.154|10.203.26.155|10.203.26.162|10.203.26.163|10.203.26.164|10.203.26.165|10.203.26.166|10.203.26.167|10.203.26.168|10.203.26.169|10.203.26.178|10.203.26.179|10.203.26.180|10.203.26.181|10.203.26.182|10.203.26.183|10.203.26.184|10.203.26.185|10.203.26.195|10.203.26.196|10.203.26.197|10.203.26.198|10.203.26.199|10.203.26.200"
          }
        ],
        "query": "select  group_concat(t1.ip SEPARATOR \"|\") from ((select * from bz_ops_ips where tag_key='product' and tag_value='olap') t1  join (select * from bz_ops_ips where tag_key='deploymentServices' and tag_value='clickhouse')t2 on t1.ip=t2.ip ) \njoin (select * from bz_ops_ips where  tag_key='cluster' and `tag_value` = '$cluster')t3  on t1.ip = t3.ip",
        "refresh": 0,
        "regex": "",
        "skipUrlSync": false,
        "sort": 0,
        "tagValuesQuery": "",
        "tags": [],
        "tagsQuery": "",
        "type": "query",
        "useTags": false
      },
      {
        "allValue": null,
        "current": {
          "selected": false,
          "text": "10.203.26.121",
          "value": "10.203.26.121"
        },
        "datasource": "MySQL_kunpeng",
        "definition": "select  t1.ip from ((select * from bz_ops_ips where tag_key='product' and tag_value='olap') t1  join (select * from bz_ops_ips where tag_key='deploymentServices' and tag_value='clickhouse') t2 on t1.ip=t2.ip ) \njoin (select * from bz_ops_ips where  tag_key='cluster' and `tag_value` = '$cluster')t3  on t1.ip = t3.ip",
        "error": null,
        "hide": 2,
        "includeAll": false,
        "label": null,
        "multi": false,
        "name": "IP",
        "options": [
          {
            "selected": true,
            "text": "10.203.26.121",
            "value": "10.203.26.121"
          },
          {
            "selected": false,
            "text": "10.203.26.122",
            "value": "10.203.26.122"
          },
          {
            "selected": false,
            "text": "10.203.26.123",
            "value": "10.203.26.123"
          },
          {
            "selected": false,
            "text": "10.203.26.130",
            "value": "10.203.26.130"
          },
          {
            "selected": false,
            "text": "10.203.26.131",
            "value": "10.203.26.131"
          },
          {
            "selected": false,
            "text": "10.203.26.132",
            "value": "10.203.26.132"
          },
          {
            "selected": false,
            "text": "10.203.26.133",
            "value": "10.203.26.133"
          },
          {
            "selected": false,
            "text": "10.203.26.134",
            "value": "10.203.26.134"
          },
          {
            "selected": false,
            "text": "10.203.26.135",
            "value": "10.203.26.135"
          },
          {
            "selected": false,
            "text": "10.203.26.136",
            "value": "10.203.26.136"
          },
          {
            "selected": false,
            "text": "10.203.26.137",
            "value": "10.203.26.137"
          },
          {
            "selected": false,
            "text": "10.203.26.138",
            "value": "10.203.26.138"
          },
          {
            "selected": false,
            "text": "10.203.26.139",
            "value": "10.203.26.139"
          },
          {
            "selected": false,
            "text": "10.203.26.146",
            "value": "10.203.26.146"
          },
          {
            "selected": false,
            "text": "10.203.26.147",
            "value": "10.203.26.147"
          },
          {
            "selected": false,
            "text": "10.203.26.148",
            "value": "10.203.26.148"
          },
          {
            "selected": false,
            "text": "10.203.26.149",
            "value": "10.203.26.149"
          },
          {
            "selected": false,
            "text": "10.203.26.150",
            "value": "10.203.26.150"
          },
          {
            "selected": false,
            "text": "10.203.26.151",
            "value": "10.203.26.151"
          },
          {
            "selected": false,
            "text": "10.203.26.152",
            "value": "10.203.26.152"
          },
          {
            "selected": false,
            "text": "10.203.26.153",
            "value": "10.203.26.153"
          },
          {
            "selected": false,
            "text": "10.203.26.154",
            "value": "10.203.26.154"
          },
          {
            "selected": false,
            "text": "10.203.26.155",
            "value": "10.203.26.155"
          },
          {
            "selected": false,
            "text": "10.203.26.162",
            "value": "10.203.26.162"
          },
          {
            "selected": false,
            "text": "10.203.26.163",
            "value": "10.203.26.163"
          },
          {
            "selected": false,
            "text": "10.203.26.164",
            "value": "10.203.26.164"
          },
          {
            "selected": false,
            "text": "10.203.26.165",
            "value": "10.203.26.165"
          },
          {
            "selected": false,
            "text": "10.203.26.166",
            "value": "10.203.26.166"
          },
          {
            "selected": false,
            "text": "10.203.26.167",
            "value": "10.203.26.167"
          },
          {
            "selected": false,
            "text": "10.203.26.168",
            "value": "10.203.26.168"
          },
          {
            "selected": false,
            "text": "10.203.26.169",
            "value": "10.203.26.169"
          },
          {
            "selected": false,
            "text": "10.203.26.178",
            "value": "10.203.26.178"
          },
          {
            "selected": false,
            "text": "10.203.26.179",
            "value": "10.203.26.179"
          },
          {
            "selected": false,
            "text": "10.203.26.180",
            "value": "10.203.26.180"
          },
          {
            "selected": false,
            "text": "10.203.26.181",
            "value": "10.203.26.181"
          },
          {
            "selected": false,
            "text": "10.203.26.182",
            "value": "10.203.26.182"
          },
          {
            "selected": false,
            "text": "10.203.26.183",
            "value": "10.203.26.183"
          },
          {
            "selected": false,
            "text": "10.203.26.184",
            "value": "10.203.26.184"
          },
          {
            "selected": false,
            "text": "10.203.26.185",
            "value": "10.203.26.185"
          },
          {
            "selected": false,
            "text": "10.203.26.195",
            "value": "10.203.26.195"
          },
          {
            "selected": false,
            "text": "10.203.26.196",
            "value": "10.203.26.196"
          },
          {
            "selected": false,
            "text": "10.203.26.197",
            "value": "10.203.26.197"
          },
          {
            "selected": false,
            "text": "10.203.26.198",
            "value": "10.203.26.198"
          },
          {
            "selected": false,
            "text": "10.203.26.199",
            "value": "10.203.26.199"
          },
          {
            "selected": false,
            "text": "10.203.26.200",
            "value": "10.203.26.200"
          }
        ],
        "query": "select  t1.ip from ((select * from bz_ops_ips where tag_key='product' and tag_value='olap') t1  join (select * from bz_ops_ips where tag_key='deploymentServices' and tag_value='clickhouse') t2 on t1.ip=t2.ip ) \njoin (select * from bz_ops_ips where  tag_key='cluster' and `tag_value` = '$cluster')t3  on t1.ip = t3.ip",
        "refresh": 0,
        "regex": "",
        "skipUrlSync": false,
        "sort": 0,
        "tagValuesQuery": "",
        "tags": [],
        "tagsQuery": "",
        "type": "query",
        "useTags": false
      }
    ]
  },
  "time": {
    "from": "now-1h",
    "to": "now"
  },
  "timepicker": {
    "hidden": false,
    "refresh_intervals": [
      "1m",
      " 5m"
    ]
  },
  "timezone": "",
  "title": "system-baize",
  "uid": "72AP0qiMz",
  "version": 161
}
```

