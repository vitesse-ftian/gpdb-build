set -e

function fatal
{
   echo
   echo ERROR: "$@"
   echo
   exit 1
}


STARTTIME=0
function start
{
   echo -n $1
   STARTTIME=$(date +%s)
}


function pass 
{
   ENDTIME=$(date +%s)
   ELAPSED=$(($ENDTIME - $STARTTIME))
   echo "[ok  $ELAPSED sec]"
}

function fail
{
   echo '[fail]'
   if [ $1 ]; then echo "$@"; fi
}

if [ "x$GPDB_BUILD_DIR" == "x" ]; then 
   fatal "please set GPDB_BUILD_DIR"
fi

TARGETDIR=/usr/local
export PATH="$TARGETDIR/bin:$PATH"
mkdir -p out

##########################
start 'cmake: ..........'
(F=cmake-3.5.2; rm -rf $F && tar xf $F.tar.gz && cd $F \
  && ./configure --prefix=$TARGETDIR  \
  && make clean && make -j8 && sudo make install) >& out/cmake.out && pass || fail

##########################
start 'proj: ...........'
 (F=proj.4-4.9.3; rm -rf $F && tar xf $F.tar.gz && cd $F \
   && mkdir -p build && cd build \
   && cmake -DCMAKE_INSTALL_PREFIX:PATH=$TARGETDIR .. \
   && make -j8  \
   && sudo make install ) >& out/proj.out && pass || fail
 
##########################
start 'geos: ...........'
(F=geos-3.4.2; rm -rf $F && tar xf $F.tar.gz && cd $F \
  && mkdir -p build && cd build \
  && cmake -DCMAKE_INSTALL_PREFIX:PATH=$TARGETDIR .. \
  && make -j8  \
  && sudo make install ) >& out/geos.out && pass || fail
 
##########################
start 'gdal: ...........'
(F=gdal-2.1.1; rm -rf $F && tar xf $F.tar.gz && cd $F \
  && ./configure --prefix=$TARGETDIR --with-xml2=/usr/bin/xml2-config \
	--with-geos=$TARGETDIR/bin/geos-config \
  && make clean && make \
  && sudo make install ) >& out/gdal.out && pass || fail

#########################
start 'running ldconfig'
sudo ldconfig 2>&1 > out/ldconfig.out
