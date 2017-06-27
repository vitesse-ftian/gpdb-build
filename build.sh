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

echo "Building GPDB in dir $GPDB_BUILD_DIR, build branch $1"

(cd gpdb && git checkout $1)
(cd gporca && git checkout $1)
(cd gp-xerces && git checkout $1)
(cd incubator-madlib && git checkout $1)

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

############################
start 'postgis: ..........'
(cd gpdb/contrib/postgis && \
    ./configure --with-projdir=/usr/local --with-geosconfig=/usr/local/bin/geos-config --prefix=$GPDB_BUILD_DIR/installed) 2>&1 > out/postgis.out || fail
(cd gpdb/contrib/postgis && \
    make clean &&
    make && \
    make install ) 2>&1 >> out/postgis.out || fail

