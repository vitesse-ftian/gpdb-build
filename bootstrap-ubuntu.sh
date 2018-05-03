sudo apt-get update
sudo apt-get install -y git vim tmux openssh-client openssh-server sudo
sudo apt-get install -y flex bison autoconf libtool bzip2 unzip
sudo apt-get install -y libyaml-dev libreadline-dev zlib1g-dev libssl-dev
sudo apt-get install -y python-dev libpython-dev
sudo apt-get install -y libcurl4-openssl-dev
sudo apt-get install -y libevent-dev libxml2 libxml2-dev libbz2-dev
sudo apt-get install -y libapr1-dev
sudo apt-get install -y python-pip
sudo pip2 install --upgrade pip
sudo pip2 install setuptools
sudo pip2 install psutil
sudo pip2 install lockfile
sudo pip2 install paramiko

git clone https://github.com/greenplum-db/gpdb.git 
(cd gpdb; git checkout 5X_STABLE)
git clone https://github.com/greenplum-db/gporca.git
(cd gporca; git fetch --all --tags --prune; git checkout tags/v2.54.2)
git clone https://github.com/greenplum-db/gp-xerces.git
git clone https://github.com/apache/madlib.git 
git clone https://github.com/greenplum-db/geospatial.git
