```c++


class Daemon
{
    Cluster ;
};

class Cluster
{
public:

};
using Clusters = std::list<Cluster>;


class Group
{

};




class JasonBucket
{
private:
    String  _version;
    String  _storage_path;
    String  getVersion_(){
        return _version;
    }
    String  getStroagePath(){
        return _storage_path;
    }
    void  setVersion(String verison){

    }
    void setStoragePath(String storagePath){

    }

};

class JasonPartition
{
    using _JasonBucket = std::vector<JasonBucket>;
    _JasonBucket  _jason_bucket;
};

using JasonPartitionPtr = std::shared_ptr<JasonPartition>();


class JasonTable
{
    using _JasonParitions

        = std::vector<JasonPartitionPtr>;
    _JasonParitions  _jason_partitions;
};

class JasonGroup
{

};



```

