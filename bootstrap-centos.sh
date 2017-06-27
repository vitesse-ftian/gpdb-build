sudo yum install -y unzip which tar more git vim util-linux-ng
sudo yum install -y net-tools iproute ncurses ncurses-devel
sudo yum groupinstall -y "Development Tools"
sudo yum install -y epel-release
sudo yum install -y openssl openssl-libs openssl-devel
sudo yum install -y readline readline-devel apr-devel
sudo yum install -y bzip2 bzip2-devel 
sudo yum install -y libevent libevent-devel
sudo yum install -y libcurl libcurl-devel
sudo yum install -y libxml2 libxml2-devel
sudo yum install -y python-devel
sudo yum install -y python-pip
sudo pip install --upgrade pip
sudo pip install psutil
sudo pip install lockfile 
sudo pip install paramiko 
sudo pip install setuptools

echo '/usr/local/lib' > ./usrlocal.conf
sudo mv ./usrlocal.conf /etc/ld.so.conf.d/
sudo ldconfig -v

git clone https://github.com/vitesse-ftian/gpdb.git
git clone https://github.com/vitesse-ftian/gp-xerces.git
git clone https://github.com/vitesse-ftian/incubator-madlib.git

