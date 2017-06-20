#!/bin/bash

(cd gpdb && git checkout $1)
(cd gporca && git checkout $1)
(cd incubator-madlib && git checkout $1)
(cd postgis && git checkout $1)
