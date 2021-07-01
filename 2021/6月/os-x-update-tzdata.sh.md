```shell
#!/bin/bash
# author: Tomás Girardi
# Based on http://helw.net/2011/04/28/updating-osx-for-egypts-dst-changes/ by Ahmed El-Helw

# CHANGE THIS: 
# go to https://www.iana.org/time-zones and get the URL for the last DATA
# release
URLTZDATASRC=https://www.iana.org/time-zones/repository/releases/tzdata2016d.tar.gz

# BACKUP your current icu file first
cp /usr/share/icu/*.dat ~

ICUVERSION=`ls /usr/share/icu/*.dat | grep -o "\(\d\d\)l\.dat" | grep -o "^\d\d"`
URLICUSRC="http://download.icu-project.org/files/icu4c/${ICUVERSION}.1/icu4c-${ICUVERSION}_1-src.zip"

### update tzdata
cd /tmp
mkdir tzdata
cd tzdata
wget "${URLTZDATASRC}"
tar -xzf tzdata2016d.tar.gz
sudo zic africa
sudo zic antarctica
sudo zic asia
sudo zic australasia
sudo zic backward
sudo zic etcetera
sudo zic europe
sudo zic factory
sudo zic northamerica
sudo zic pacificnew
sudo zic southamerica
sudo zic systemv

### update ICU data
cd /tmp
mkdir icu4c
cd icu4c
wget "${URLICUSRC}" -O icusrc.tar.gz
tar xzf icusrc.tar.gz
cd icu/source/tools/tzcode
# ./icuSources/tools/tzcode/readme.txt tells us that placing a tzdata
# file in the tzcode directory will compile with that zoneinfo database

# download latest tzdata
wget "${URLTZDATASRC}"
cd ../..

# compile
./runConfigureICU MacOSX --with-data-packaging=archive
gnumake

# replace the data file only
sudo install -o root -g wheel -m 0644 -Sp "data/out/icudt${ICUVERSION}l.dat" "/usr/share/icu/icudt${ICUVERSION}l.dat"

# NOW REBOOT!!!
```

