#!/bin/sh -xe

BASE_DIR=/tmp/base/
SRC_DIR=/tmp/src/
NAME=influxdb-relay
RELEASE=`date +"%Y%m%d"`
TOP_DIR=/tmp/rpmbuild
SOURCES_DIR=$TOP_DIR/SOURCES
VERSION=0.0.1
mkdir -p $SRC_DIR
mkdir -p $SOURCES_DIR
mkdir -p $SRC_DIR/etc

export GOPATH=/opt/go/
go get -u github.com/influxdata/influxdb-relay
cp $GOPATH/src/github.com/influxdata/influxdb-relay/sample.toml $SRC_DIR/etc/relay.toml

cp /opt/go/bin/influxdb-relay $SRC_DIR
cp -r $BASE_DIR $SRC_DIR

cd $SRC_DIR/../
tar -cf $SOURCES_DIR/src.tar.gz src

rpmbuild --bb base/rpm.spec \
    --define "_topdir ${TOP_DIR}" \
    --define "name ${NAME}" \
    --define "version ${VERSION}" \
    --define "release ${RELEASE}"

cp /tmp/rpmbuild/RPMS/x86_64/* /opt/yumrepo/centos/7/x86_64
