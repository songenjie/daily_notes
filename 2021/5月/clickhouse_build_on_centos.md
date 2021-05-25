```shell
# Tested on Centos 6.9 and Centos 7.4. ClickHouse vesion 1.1.54236
# Official build instructions:
# https://github.com/yandex/ClickHouse/blob/master/doc/build.md
# See also https://github.com/redsoftbiz/clickhouse-rpm
#      and https://github.com/Altinity/clickhouse-rpm

export THREADS=$(grep -c ^processor /proc/cpuinfo)

# Determine RHEL major version
RHEL_VERSION=`rpm -qa --queryformat '%{VERSION}\n' '(redhat|sl|slf|centos|oraclelinux|goslinux)-release(|-server|-workstation|-client|-computenode)'`

# add extra repos
yum -y install epel-release centos-release-scl

# installing needed libs
yum -y install readline-devel unixODBC-devel openssl-devel libicu-devel libtool-ltdl-devel openssl-devel 

# installing libmysqlclient
# centos repos doesn't provide static library for libmysqlclient
# So we use one from mysql57-community-release repo (as an option it can also be taken from MariaDB-devel or rebuilded from sources / srpm package)
# For dynamic linking mysql-devel from base centos repo would be ok.
yum -y install http://dev.mysql.com/get/mysql57-community-release-el$RHEL_VERSION-11.noarch.rpm
yum -y install mysql-community-devel

# installing build tools
# devtoolset-6 - is a software collection containing gcc 6 from software-collections repo (centos-release-scl)
# cmake3 from epel repo - as it compatible both with ClickHouse and clang (cmake from base repo has 2.X version, not supported by clang)
yum -y install git cmake3 devtoolset-6 tar wget

#### CLANG  #####
## if you're planning to use precompilation of request in runtime - you will also need to build / install clang compiler
## see https://clickhouse.yandex/docs/en/settings/settings.html#compile 
#
## clang compiling can take hours and few gigabites of disk space
yum -y install python27 xz #centos7 actually already have python 2.7. so it can be skipped (but python27 from software collections also works)

## See repo with binary distribution of clang: https://copr.fedorainfracloud.org/coprs/alonid/

mkdir llvm && cd llvm
mkdir -p llvm/tools/clang llvm/projects/compiler-rt build
wget -qO- http://releases.llvm.org/4.0.0/llvm-4.0.0.src.tar.xz        | tar xf - -J --strip-components=1 -Cllvm
wget -qO- http://releases.llvm.org/4.0.0/cfe-4.0.0.src.tar.xz         | tar xf - -J --strip-components=1 -Cllvm/tools/clang
wget -qO- http://releases.llvm.org/4.0.0/compiler-rt-4.0.0.src.tar.xz | tar xf - -J --strip-components=1 -Cllvm/projects/compiler-rt

cd build
# scl enable - set the ENV for the passed command to use software from the collection(s)
scl enable devtoolset-6 python27 'cmake3 -D CMAKE_BUILD_TYPE:STRING=Release ../llvm'
scl enable devtoolset-6 python27 'make -j $THREADS'
scl enable devtoolset-6 python27 'make install'
hash clang
cd ../..

# as i understand for clickhouse only clang binary is needed (see https://github.com/yandex/ClickHouse/blob/master/debian/copy_clang_binaries.sh )
# but whole llvm+clang distribution contains a lot of other stuff (about 1Gb installed)
# Possible solution: clang executable  can be built and installed standalone like that (will take less diskspace)
#scl enable devtoolset-6 python27 'make clang -j $THREADS'
#scl enable devtoolset-6 python27 'make install-clang' 
# (should be tested if there are no hidden dependencies)

#### CLANG END  #####

mkdir -p ClickHouse/build
wget -qO- https://github.com/yandex/ClickHouse/archive/stable.tar.gz | tar -xzf - --strip-components=1 -CClickHouse
# for development it's better to clone Clickhouse repo
# git clone -b stable https://github.com/yandex/ClickHouse.git

cd ClickHouse/build
# build (release) using compilers from devtoolset-6 software collection
scl enable devtoolset-6 'CC=gcc CXX=g++ cmake3 -DCMAKE_BUILD_TYPE:STRING=Release ..'
scl enable devtoolset-6 'make -j $THREADS'
scl enable devtoolset-6 'make install' #  DESTDIR=/tmp/

clickhouse-server --config=/usr/local/etc/clickhouse-server/config.xml

## TODO: run tests for compiled stuff?
```





https://gist.github.com/filimonov/0aa441717d0faf9b77d7099bc61a1e9e