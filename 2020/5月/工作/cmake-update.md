
- wget https://cmake.org/files/v3.6/cmake-3.6.2.tar.gz

- tar -zxvf cmake-3.6.2.tar.gz

- cd cmake-3.6.2

- sudo ./bootstrap --prefix=/usr/local

- make

- make install

- vim ~/.bash_profile

- PATH=/usr/local/bin:$PATH:$HOME/bin

- source ~/.bash_profile

- cmak --version

