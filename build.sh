#!/bin/bash

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

TARGETDIR=$GPDB_BUILD_DIR/installed
export PATH="$TARGETDIR/bin:$PATH"
mkdir -p out

##########################
rm -rf installed 
mkdir -p installed

BUILD_BRANCH=$1
if [ "x$1" == "x" ]; then 
    echo "Use default branch: release"
    BUILD_BRANCH=release
fi

echo "Building GPDB in dir $GPDB_BUILD_DIR, build branch $BUILD_BRANCH"

(cd gpdb && git checkout $BUILD_BRANCH)
(cd gporca && git checkout $BUILD_BRANCH)
(cd gp-xerces && git checkout $BUILD_BRANCH)
(cd incubator-madlib && git checkout $BUILD_BRANCH)
(cd geospatial && git checkout $BUILD_BRANCH)

(cd ext && bash ./build.sh)

echo $GPDB_BUILD_DIR/installed > INSTALLDIR

###########################
start 'gp-xerces: ........' 
(cd gp-xerces \
  && ./configure --prefix=/usr/local \
  && make clean && make -j8 && sudo make install) >& out/gp-xerces.out && pass || fail

###########################
start 'gporca: ...........'
(cd gporca && bash ./build.sh) >& out/gporca.out && pass || fail

###########################
start 'ldconfig ..........'
sudo ldconfig 2>&1 > out/ldconfig.out && pass || fail

###########################
start 'gpdb: .............'
(cd gpdb && bash ./build.sh) >& out/gpdb.out && pass || fail

###########################
start 'postgis: ..........'
(cd geospatial/postgis/build/postgis-2.1.5 \
  && ./configure --with-pgconfig=$GPDB_BUILD_DIR/installed/bin/pg_config --with-raster --without-topology --prefix=$GPDB_BUILD_DIR/installed \
  && make USE_PGXS=1 clean all install) >& out/postgis.out && pass || fail

