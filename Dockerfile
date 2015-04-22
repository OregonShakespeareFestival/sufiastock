############################################################
# A Docker Container Installation of Sufia 6.0
# To-Do 
# Install Fits
# Install ffmpeg
############################################################

#Declare CentOS the latest
FROM centos

Maintainer Andrew J Krug

#Declare the Rails Environment
ENV RAILS_ENV production

RUN yum update -y

RUN yum install epel-release -y

RUN rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-1.el7.nux.noarch.rpm

RUN yum install -y nginx curl nodejs
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

RUN yum install unzip -y

RUN yum install git gcc make rubygem-nokogiri libxslt libxslt-devel libxml2 libxml2-devel sqlite-devel openssl-devel ruby-devel rubygem-devel rubygem-bundler ImageMagick ImageMagick-devel -y

RUN yum install redis -y

RUN yum install fpack -y

RUN yum install libreoffice-headless -y

RUN gem install nokogiri -- --use-system-libraries

ADD config/container/nginx-sites.conf /etc/nginx/conf.d/default.conf
ADD config/container/start-server.sh /usr/bin/start-server
RUN chmod +x /usr/bin/start-server

# Add rails project to project directory
ADD ./ /rails

# set WORKDIR
WORKDIR /rails

# bundle install
RUN /bin/bash -l -c "bundle install"
RUN bundle exec rake assets:precompile --trace

# copy the rest of the app
ADD / /rails/app/

RUN rake db:create
RUN rake db:migrate
RUN rake db:seed

#RUN jetty:config

# Publish port 80
EXPOSE 80
EXPOSE 6379

# Startup commands
ENTRYPOINT /usr/bin/start-server 
