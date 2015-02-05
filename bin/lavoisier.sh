#!/bin/sh
BASEDIR=`dirname $0`/..
BASEDIR=`(cd "$BASEDIR"; pwd)`
$BASEDIR/jsw/lavoisier/bin/lavoisier $*
