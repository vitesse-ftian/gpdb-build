sudo apt-get update
sudo apt-get install -y git vim tmux openssh-client openssh-server sudo
sudo apt-get install -y flex bison autoconf libtool bzip2 unzip
sudo apt-get install -y libyaml-dev libreadline-dev zlib1g-dev libssl-dev
sudo apt-get install -y python-dev libpython-dev
sudo apt-get install -y libcurl4-openssl-dev
sudo apt-get install -y libevent-dev libxml2 libxml2-dev libbz2-dev
sudo apt-get install -y libapr1-dev
sudo apt-get install -y python-pip
sudo pip install --upgrade pip
sudo pip install setuptools
sudo pip install psutil
sudo pip install lockfile
sudo pip install paramiko

git clone https://github.com/vitesse-ftian/gpdb.git
git clone https://github.com/vitesse-ftian/gporca.git
git clone https://github.com/vitesse-ftian/gp-xerces.git
git clone https://github.com/vitesse-ftian/incubator-madlib.git
