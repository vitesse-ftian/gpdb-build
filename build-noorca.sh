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

echo "Building GPDB in dir $GPDB_BUILD_DIR" 

(cd gpdb && git checkout 5X_STABLE)
echo $GPDB_BUILD_DIR/installed > INSTALLDIR

###########################
# configure for debug build should be
start 'gpdb: .............'
(cd gpdb && ./configure --prefix=$GPDB_BUILD_DIR/installed --with-openssl --with-python --with-libxml --enable-debug --enable-cassert --disable-orca CFLAGS='-O0 -fno-inline' && make && make install ) >& out/gpdb.out && pass || fail

########################### 
# The following is -O3 opt bulid.
# (cd gpdb && ./configure --prefix=$GPDB_BUILD_DIR/installed --with-openssl --with-python --with-libxml CFLAGS='-O3' && make && make install ) >& out/gpdb.out && pass || fail

