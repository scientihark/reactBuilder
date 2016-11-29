# gulp
FROM ubuntu:14.04
MAINTAINER scientihark

# Commands
ADD  sources.list.trusty /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y python2.7 git wget
RUN \
  wget -O '/tmp/node-v4.4.6-linux-x64.tar.gz' https://nodejs.org/dist/v4.4.6/node-v4.4.6-linux-x64.tar.gz && \
  tar --strip-components=1 -xvf '/tmp/node-v4.4.6-linux-x64.tar.gz' -C /usr/local && \
  apt-get autoremove -y && \
  apt-get clean all

RUN ln -s /usr/bin/python2.7 /usr/bin/python
RUN mkdir -p /srv/var
RUN cd /srv/var/ &&/usr/local/bin/npm install -g gulp -d
RUN cd /srv/var/ &&/usr/local/bin/npm install gulp gulp-git gulp-minify-css gulp-prompt gulp-sass gulp-sftp gulp-template gulp-uglify gulp-util gulp-version-number pump webpack webpack-stream -d

ADD gulpDev.sh /usr/local/bin/
ADD gulpDebug.sh /usr/local/bin/
ADD gulpRelease.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/gulpDev.sh
RUN chmod +x /usr/local/bin/gulpDebug.sh
RUN chmod +x /usr/local/bin/gulpRelease.sh
RUN ln -s /usr/local/bin/gulpDev.sh /usr/bin/gulpDev
RUN ln -s /usr/local/bin/gulpDebug.sh /usr/bin/gulpDebug
RUN ln -s /usr/local/bin/gulpRelease.sh /usr/bin/gulpRelease

