############################################################
# A Docker Container Installation of Sufia 6.0
############################################################

#Declare CentOS the latest
FROM centos

Maintainer Andrew J Krug

#Declare the Rails Environment
ENV RAILS_ENV production

#Add Blacklight Secret Throwaway ENV to facilitate build. ( this will be overriddden at container start )
#
ENV SECRET_KEY_BASE 679d736b2d27d018a28348a2f08286bb05f9827fe977a82add180b7dc18c229871b289a7ee747ef8c71945556fc30cafd7a734575559d634821441dee024cecd
ENV OSFSUFIA_DATABASE osfsufia
ENV OSFSUFIA_DATABASE_USER sufia
ENV OSFSUFIA_DATABASE_PASSWORD archive2015

RUN yum update -y

RUN yum install epel-release -y

RUN rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-1.el7.nux.noarch.rpm

#RUN yum install git gcc make rubygem-nokogiri libxslt libxslt-devel libxml2 libxml2-devel sqlite-devel openssl-devel ruby-devel rubygem-devel rubygem-bundler ImageMagick ImageMagick-devel mariadb mariadb-devel -y
RUN yum install -y \
  tar \
  nginx \
  curl \
  nodejs \
  unzip \
  patch \
  libyaml-devel \
  autoconf \
  gcc-c++ \
  readline-devel \
  zlib-devel \
  libffi-devel \
  openssl-devel \
  automake \
  libtool \
  bison \
  git \
  gcc \
  make \
  libxslt \
  libxslt-devel \
  libxml2 \
  libxml2-devel \
  sqlite-devel \
  openssl-devel \
  ImageMagick \
  ImageMagick-devel \
  mariadb \
  mariadb-devel

RUN gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

RUN \curl -sSL https://get.rvm.io | bash -s stable

RUN /bin/bash -l -c "rvm install 2.1"

RUN /bin/bash -l -c "rvm --default use 2.1"

RUN yum install redis -y

RUN yum install fpack -y

RUN yum install libreoffice-headless -y

RUN /bin/bash -l -c "gem install nokogiri -- --use-system-libraries"
RUN /bin/bash -l -c "gem install bundler"

ADD config/container/start-server.sh /usr/bin/start-server
ADD ffmpeg/bin/ffmpeg /usr/bin/ffmpeg
ADD ffmpeg/bin/ffprobe /usr/bin/ffprobe
ADD ffmpeg/bin/ffserver /usr/bin/ffserver
ADD ffmpeg/bin/lame /usr/bin/lame
ADD ffmpeg/bin/vsyasm /usr/bin/vsyasm
ADD ffmpeg/bin/x264 /usr/bin/x264
ADD ffmpeg/bin/yasm /usr/bin/yasm
ADD ffmpeg/bin/ytasm /usr/bin/ytasm

# Add rails project to project directory
ADD ./ /rails

# set WORKDIR
WORKDIR /rails

# bundle install
RUN /bin/bash -l -c "bundle install"
RUN /bin/bash -l -c "bundle exec rake assets:precompile --trace"

# Publish port 80
EXPOSE 80
EXPOSE 6379

# Startup commands
ENTRYPOINT /usr/bin/start-server
