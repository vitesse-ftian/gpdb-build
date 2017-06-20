sudo yum install -y unzip which tar more git vim util-linux-ng
sudo yum install -y net-tools iproute ncurses ncurses-devel
sudo yum groupinstall -y "Development Tools"

git clone https://github.com/vitesse-ftian/gpdb.git
git clone https://github.com/vitesse-ftian/gporca.git
git clone https://github.com/vitesse-ftian/incubator-madlib.git
git clone https://github.com/vitesse-ftian/postgis.git
