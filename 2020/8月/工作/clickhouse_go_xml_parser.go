package conf

import (
	"encoding/xml"
)

// Server holds the origin config of an instance
type Server struct {
	host string
	port int
}

// CkConfig is the full config for a clickhouse instance
type CkConfig struct {
	Main    *CkManConfig
	Metrika MetrikaConfig
	User    UserConfig
}

// ClusterConfig is the config collections of a clickhouse cluster
type ClusterConfig struct {
	Name    string               // cluster name
	ConfMap map[string]*CkConfig // key is the cluster instance addr
}

// CkManConfig hold configs of config.xml in ck
type CkManConfig struct {
	XMLName xml.Name

	HTTPPort  int
	TCPPort   int
	MysqlPort int

	InternalServerHTTPPort int
	ListenHost             string

	UserAccessControllPath string

	Prometheus *PrometheusConfig

	// TODO add other config
}

// PrometheusConfig hold the prometheus config
type PrometheusConfig struct {
	Endpoint string
	Port     int

	Metrics             bool
	Events              bool
	AsynchronousMetrics bool
	StatusInfo          bool
}

// UserConfig holds configs of users.xml
type UserConfig struct {
	//TODO add fields
}

// MetrikaConfig hold configs of metrika.xml
type MetrikaConfig struct {
	XMLName      xml.Name
	RemoteServer []*CkCluster `xml:"clickhouse_remote_servers>one_cluster"`

	MacroShard   string `xml:"macro>shard"`
	MacroReplica string `xml:"macro>replica"`

	ZookeeperServer []*ZookeeperNode `xml:"zookeeper-servers>node"`
	// TODO add other fields
}

// ZookeeperNode hold zookeeper config of a zk cluster
type ZookeeperNode struct {
	Index int    `xml:"index,attr"`
	Host  string `xml:"host"`
	Port  int    `xml:"port"`
}

// CkCluster holds config of a cluster definied in metrika.xml
type CkCluster struct {
	XMLName xml.Name
	Shared  []*CkShard `xml:"shard"`
}

// CkShard holds config of a shard definied in metrika.xml
type CkShard struct {
	InternalReplication bool         `xml:"internal_replication"`
	Replicas            []*CkReplica `xml:"replica"`
}

// CkReplica holds config of a replica definied in metrika.xml
type CkReplica struct {
	Host     string `xml:"host"`
	Port     int    `xml:"port"`
	User     string `xml:"user,omitempty"`
	Password string `xml:"password,omitempty"`
}

