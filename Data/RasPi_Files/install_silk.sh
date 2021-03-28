echo "INSTALL SILK"
# Commands copied fom SiLK install guide
sudo apt install build-essential -y
sudo apt install libglib2.0-dev liblzo2-dev zlib1g-dev libgnutls28-dev libpcap-dev python2.7-dev -y
mkdir SiLK_Install
cd SiLK_Install
wget https://tools.netsa.cert.org/releases/silk-3.18.1.tar.gz
wget https://tools.netsa.cert.org/releases/libfixbuf-2.3.1.tar.gz
wget https://tools.netsa.cert.org/releases/yaf-2.11.0.tar.gz
tar -zxf libfixbuf-2.3.1.tar.gz
cd libfixbuf-2.3.1
./configure --prefix=/usr/local --enable-silent-rules
make
sudo make install
cd ..
tar -zxf silk-3.18.1.tar.gz
cd silk-3.18.1
./configure                              \
    --prefix=/usr/local                  \
    --enable-silent-rules                \
    --enable-data-rootdir=/var/silk/data \
    --enable-ipv6                        \
    --enable-ipset-compatibility=3.14.0  \
    --enable-output-compression          \
    --with-python                        \
    --with-python-prefix
make
sudo make install
cd ..
tar -zxf yaf-2.11.0.tar.gz
cd yaf-2.11.0
./configure                 \
    --prefix=/usr/local     \
    --enable-silent-rules   \
    --enable-applabel       \
    --enable-metadata       \
    --enable-plugins
make
sudo make install
cd ..
sudo cp ./yaf-2.11.0/etc/init.d/yaf /etc/init.d/yaf
sudo chmod a+x /etc/init.d/yaf
sudo ldconfig
grep local /etc/ld.so.conf.d/*