https://github.com/Altinity/clickhouse-rpm-install



# How to Install ClickHouse with RPM packages from Altinity's repo(s)

------

## Table of Contents

- [What is this](https://github.com/Altinity/clickhouse-rpm-install#what-is-this)
- [Introduction](https://github.com/Altinity/clickhouse-rpm-install#introduction)
- Script-based installation
  - [Install dependencies](https://github.com/Altinity/clickhouse-rpm-install#install-dependencies)
  - [Install packages](https://github.com/Altinity/clickhouse-rpm-install#install-packages)
- Manual installation
  - [Install required packages](https://github.com/Altinity/clickhouse-rpm-install#install-required-packages)
  - Create required files
    - [EL6 repo file](https://github.com/Altinity/clickhouse-rpm-install#el6-repo-file)
    - [EL7 repo file](https://github.com/Altinity/clickhouse-rpm-install#el7-repo-file)
  - [Update cache](https://github.com/Altinity/clickhouse-rpm-install#update-cache)
  - [Install packages manually](https://github.com/Altinity/clickhouse-rpm-install#install-packages-manually)
- [Conclusion](https://github.com/Altinity/clickhouse-rpm-install#conclusion)

------

## What is this

This is a detailed explanation on how to install ready-to-use ClickHouse RPMs from Altinity's repos (either [general repo](https://packagecloud.io/Altinity/clickhouse) or [stable repo](https://packagecloud.io/Altinity/clickhouse-altinity-stable)) located on [packagecloud.io](https://packagecloud.io/Altinity). This is **not** an instructions on how to build your own hand-made RPMs. However, if you need to build your own RPMs, there is a [detailed explanation](https://github.com/Altinity/clickhouse-rpm) on how to build ClickHouse RPMs from sources with the help of Altinity's [RPM builder](https://github.com/Altinity/clickhouse-rpm)

## Introduction

### `general` and `stable` repos

Altinity provides two repos:

- `general` [repo](https://packagecloud.io/Altinity/clickhouse) with general ClickHouse releases.
- `stable` [repo](https://packagecloud.io/Altinity/clickhouse-altinity-stable) with Altinity Stable ClickHouse releases.

### Supported OSes

All instructions in this manual were tested on Centos 6.10, CentOS 7.5 and Amazon Linux 2.

**IMPORTANT for Amazon Linux users** Amazon Linux is being detected as CentOS 6, while RPMs built for CentOS 7 are the best choice. So we need to explicitly install CentOS 7 RPMs More details further in the doc.

### Register repo

In order to install ClickHouse RPM packages from Altinity's repo, we need to register it (repo) with our `yum`, making `yum` aware of additional packages installable from external source.

In general, repositories are listed in `/etc/yum.repos.d` folder, so we need to add Altinity's repo description in there.

This can be done either [manually](https://github.com/Altinity/clickhouse-rpm-install#manual-installation) or via [script](https://github.com/Altinity/clickhouse-rpm-install#script-based-installation), provided by `packagecloud.io`. In any case, as a result, we'll have ClickHouse packages available for installation via `yum`.

**IMPORTANT for Amazon Linux users** Amazon Linux is being detected as CentOS 6 by the script, so we need to explicitly instruct it to use CentOS 7 repo.

- In case of [manual installation](https://github.com/Altinity/clickhouse-rpm-install#manual-installation), just use [EL7 repo file](https://github.com/Altinity/clickhouse-rpm-install#el7-repo-file). It is compatible with Amazon Linux
- In case of [script-based installation](https://github.com/Altinity/clickhouse-rpm-install#script-based-installation), script provided by packagecloud should be explicitly instructed to use CentOS 7 repo, instead of CentOS 6 repo, which is being used by default for Amazon Linux. More details further in the doc.

Let's start with script-based installation, since this approach looks like more user-friendly.

## Script-based installation

For our convenience,`packagecloud.io` provides nice and user-friendly way to add repos with their `shell script`. We'll need to download and run **packagecloud**'s `shell script`, which will do all required steps.

### Install dependencies

Installation process requires `curl` in order to download packages. ClickHouse test package has some dependencies in EPEL, so `epel-release` has to be installed as well, in case you'd like to install ClickHouse test package. Some installations do not have `sudo` installed, so we need to ensure it is availbale also.

Ensure `sudo` is available:

```
yum install -y sudo
```

Ensure `curl` is available:

```
sudo yum install -y curl
# in case test package would be installed, add epel-release
sudo yum install -y epel-release
```

Let's download and run installation `shell script`, provided by `packagecloud.io`. First of all, we need to point what script (from `general` or `stable` repo) we'll be using:

```
# For 'general' repo use this URL:
SCRIPT_URL="https://packagecloud.io/install/repositories/altinity/clickhouse/script.rpm.sh"

# For 'stable' repo use this URL:
SCRIPT_URL="https://packagecloud.io/install/repositories/altinity/clickhouse-altinity-stable/script.rpm.sh"
```

Now we can register Altiniry's repo in the system by running appropriate script.

**for CentOS 6 and 7**:

```
curl -s "${SCRIPT_URL}" | sudo bash
```

**for Amazon Linux**:

```
curl -s "${SCRIPT_URL}" | sudo os=centos dist=7 bash
```

pay attention to `os=centos dist=7` explicitly specified.

At this point we have `yum` aware of additional RPM packages available.

We are ready to install ClickHouse.

### Install packages

First of all, ensure we have ClickHouse packages available for installation

```
sudo yum list 'clickhouse*'
```

ClickHouse packages should be listed as available, something like this:

```
Available Packages
clickhouse-client.x86_64            19.13.3.26-1.el7      Altinity_clickhouse
clickhouse-common-static.x86_64     19.13.3.26-1.el7      Altinity_clickhouse
clickhouse-compressor.x86_64        1.1.54336-3.el7       Altinity_clickhouse
clickhouse-debuginfo.x86_64         19.13.3.26-1.el7      Altinity_clickhouse
clickhouse-odbc.x86_64              1.0.0.20190611-1      Altinity_clickhouse
clickhouse-server.x86_64            19.13.3.26-1.el7      Altinity_clickhouse
clickhouse-server-common.x86_64     19.13.3.26-1.el7      Altinity_clickhouse
clickhouse-test.x86_64              19.13.3.26-1.el7      Altinity_clickhouse
```

There are multiple packages available (new versions and old tools as well), some of them are deprecated already, so there is no need to install all available RPMs.

Now let's install ClickHouse main parts - server and client applications.

#### Install latest ClickHouse version

In case we'd like to just install latest ClickHouse (it is so in most cases), we can simply install `clickhouse-server` and `clickhouse-client` as following:

```
sudo yum install -y clickhouse-server clickhouse-client
```

However, sometimes we'd like to install specific version of ClickHouse.

#### Install specific ClickHouse version

We can either just want to install latest version from specific branch, or we may know what ClickHouse version we'd like to install exactly, or we can look over availbale (older) versions available for installation. These cases are little bit different, let's take a look on both of them.

**Select latest version from specific branch**

In case we'd like to install latest version of `19.11.X.Y` family, we can list available latest `19.11.*` packages

```
sudo yum list 'clickhouse*19.11.*'
```

We'll see packages of one proposed version (latest) only:

```
Available Packages
clickhouse-client.x86_64         19.11.9.52-1.el7
clickhouse-common-static.x86_64  19.11.9.52-1.el7
clickhouse-debuginfo.x86_64      19.11.9.52-1.el7
clickhouse-server.x86_64         19.11.9.52-1.el7
clickhouse-server-common.x86_64  19.11.9.52-1.el7
clickhouse-test.x86_64           19.11.9.52-1.el7
```

**Select specific version from specific branch**

In case we'd like to see all available versions of `19.11.X.Y` family, then select preferred version out of availbale for installation:

```
sudo yum list 'clickhouse*19.11.*' --showduplicates
```

We'll see all available package versions from `19.11.X.Y` family:

```
Available Packages
clickhouse-client.x86_64         19.11.2.7-1.el7
clickhouse-client.x86_64         19.11.3.11-1.el7
clickhouse-client.x86_64         19.11.4.24-1.el7
clickhouse-client.x86_64         19.11.6.31-1.el7
clickhouse-client.x86_64         19.11.7.40-1.el7
clickhouse-client.x86_64         19.11.8.46-1.el7
clickhouse-client.x86_64         19.11.9.52-1.el7
clickhouse-common-static.x86_64  19.11.2.7-1.el7
clickhouse-common-static.x86_64  19.11.3.11-1.el7
clickhouse-common-static.x86_64  19.11.4.24-1.el7
clickhouse-common-static.x86_64  19.11.6.31-1.el7
...
and more
```

**Install specific version**

By now, we have picked up specific version (out of available) - let's install it:

```
sudo yum install -y clickhouse-server-19.11.7.40 clickhouse-client-19.11.7.40
```

and verify it is listed as installed

```
 sudo yum list installed 'clickhouse*'
```

ClickHouse packages should be listed as installed, something like this:

```
Installed Packages
clickhouse-client.x86_64                 19.11.7.40-1.el7           @Altinity_clickhouse
clickhouse-common-static.x86_64          19.11.7.40-1.el7           @Altinity_clickhouse
clickhouse-server.x86_64                 19.11.7.40-1.el7           @Altinity_clickhouse
clickhouse-server-common.x86_64          19.11.7.40-1.el7           @Altinity_clickhouse
```

Ensure ClickHouse server is running

```
sudo /etc/init.d/clickhouse-server restart
```

And connect to it with `clickhouse-client`

```
clickhouse-client
```

ClickHouse server should respond, something like this:

```
ClickHouse client version 19.11.7.40.
Connecting to localhost:9000 as user default.
Connected to ClickHouse server version 19.11.7 revision 54423.

ip-172-31-37-226.ec2.internal :)
```

Well, all looks fine and ClickHouse installed from **RPM** packages!

We are all done!

## Manual installation

Let's add any of Altinity's repos - [general](https://packagecloud.io/Altinity/clickhouse) or [stable](https://packagecloud.io/Altinity/clickhouse-altinity-stable) manually

### Install required packages

We'll need the following packages installed beforehands:

- `pygpgme` - helps handling gpg-signatures
- `yum-utils` - contains tools for handling source RPMs
- `coreutils` - contains core utils and we'll need `tee` command later
- `epel-release` - contains ClickHouse test package dependencies

```
sudo yum install -y pygpgme yum-utils coreutils epel-release
```

### Create required files

Now let's create `yum`'s repository configuration file: `/etc/yum.repos.d/altinity_clickhouse.repo`. Depending on what CentOS version you are running you may need files for EL 6 or 7 version.

```
# For 'general' repo use this URL
BASE_URL="https://packagecloud.io/altinity/clickhouse"

# For 'stable' repo use this URL
BASE_URL="https://packagecloud.io/altinity/clickhouse-altinity-stable"
```

#### EL6 repo file

EL6 (**do NOT use with Amazon Linux**) ready-to-copy+paste command to create `yum`'s repo config file.
It writes `/etc/yum.repos.d/altinity_clickhouse.repo` file:

```
cat <<EOF | sudo tee /etc/yum.repos.d/altinity_clickhouse.repo
[altinity_clickhouse]
name=altinity_clickhouse
baseurl=${BASE_URL}/el/6/\$basearch
repo_gpgcheck=1
gpgcheck=0
enabled=1
gpgkey=${BASE_URL}/gpgkey
sslverify=1
sslcacert=/etc/pki/tls/certs/ca-bundle.crt
metadata_expire=300

[altinity_clickhouse-source]
name=altinity_clickhouse-source
baseurl=${BASE_URL}/el/6/SRPMS
repo_gpgcheck=1
gpgcheck=0
enabled=1
gpgkey=${BASE_URL}/gpgkey
sslverify=1
sslcacert=/etc/pki/tls/certs/ca-bundle.crt
metadata_expire=300
EOF
```

#### EL7 repo file

EL7 **and Amazon Linux** ready-to-copy+paste command to create `yum`'s repo config file.
It writes `/etc/yum.repos.d/altinity_clickhouse.repo` file:

```
cat <<EOF | sudo tee /etc/yum.repos.d/altinity_clickhouse.repo
[altinity_clickhouse]
name=altinity_clickhouse
baseurl=${BASE_URL}/el/7/\$basearch
repo_gpgcheck=1
gpgcheck=0
enabled=1
gpgkey=${BASE_URL}/gpgkey
sslverify=1
sslcacert=/etc/pki/tls/certs/ca-bundle.crt
metadata_expire=300

[altinity_clickhouse-source]
name=altinity_clickhouse-source
baseurl=${BASE_URL}/el/7/SRPMS
repo_gpgcheck=1
gpgcheck=0
enabled=1
gpgkey=${BASE_URL}/gpgkey
sslverify=1
sslcacert=/etc/pki/tls/certs/ca-bundle.crt
metadata_expire=300
EOF
```

### Update cache

After repo files created, let's update `yum`'s cache with packges from newly added repo

```
sudo yum -q makecache -y --disablerepo='*' --enablerepo='altinity*'
```

### Install packages manually

Packages can be installed the same way as in section [Install packages](https://github.com/Altinity/clickhouse-rpm-install#install-packages) after script-based installation.

## Conclusion

Now we have ClickHouse **RPM** packages available for easy installation.