all:
	sudo docker run \
		-v ${PWD}:/tmp/base -v /opt/yumrepo/centos/7/x86_64:/opt/yumrepo/centos/7/x86_64 \
		syunkitada/centos7-rpm-builder:latest /tmp/base/build.sh
	cp /opt/yumrepo/centos/7/x86_64/openstack-manager-* ../centos/7/x86_64/
	createrepo ../centos/7/x86_64/
