# FROM base/centos
FROM centos:6
MAINTAINER @naokun776

# MySQL version
ENV MYSQL_VERSION 5.6.25


ADD docker/MySQL-5.6.25-1.el6.x86_64.rpm-bundle.tar /home/MySQL-5.6.25-1.el6.x86_64.rpm-bundle.tar
ADD docker/epel-release-6-8.noarch.rpm /home/epel-release-6-8.noarch.rpm

# for MySQL
RUN yum -y install /home/MySQL-$MYSQL_VERSION-1.el6.x86_64.rpm-bundle.tar/MySQL-{client,devel,embedded,server,shared,shared-compact}-$MYSQL_VERSION-1.el6.x86_64.rpm \
 && rm /home/MySQL-$MYSQL_VERSION-1.el6.x86_64.rpm-bundle.tar/MySQL-*.rpm \
 && rm -r /home/MySQL-$MYSQL_VERSION-1.el6.x86_64.rpm-bundle.tar

RUN rpm -Uvh /home/epel-release-6-8.noarch.rpm
RUN yum -y install wget unzip git tar vi supervisor

ADD ./docker/db/initial.sql /home/db/initial.sql
ADD ./docker/boot.sh /home/boot.sh
ADD ./docker/my.cnf /etc/my.cnf
ADD ./docker/supervisor.conf /etc/supervisord.conf

RUN chmod +x /home/boot.sh \
 && chmod 644 /etc/my.cnf

# setup db for Centurion DB
RUN service mysql restart \
 && export MYSQL_PWD=`cat /root/.mysql_secret | awk '{ print $18}'`;mysql -u root -p$MYSQL_PWD --connect-expired-password < /home/db/initial.sql

