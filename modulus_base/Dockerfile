FROM ubuntu:14.04
MAINTAINER Alexis DUQUE "alexis.duque@openmrs.org"

ENV GRAILS_PORT 8080

#Add universe repository and update
RUN echo "debconf debconf/frontend select Teletype" | debconf-set-selections &&apt-get -y update &&\
	apt-get -y install software-properties-common &&\
    add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe" &&\
    add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc)-updates main universe" 

RUN apt-get -y update &&\
    apt-mark hold initscripts &&\
    apt-get -y upgrade

RUN mkdir -p /var/run/sshd &&\
    mkdir -p /var/log/supervisor &&\
    mkdir -p /var/lib/mysql

#Install OpenSSH and Supervisor
RUN apt-get install -y openssh-server openssl ssl-cert
RUN mkdir -p /root/.ssh &&\
	echo "root:password" | chpasswd
RUN sed --in-place=.bak 's/without-password/yes/' /etc/ssh/sshd_config

#Install Mysql server
RUN apt-get -y update && apt-get install -y wget mysql-server curl git build-essential libssl-dev supervisor tar unzip

#Download and setup Java Oracle JDK7
RUN sed 's/main$/main universe/' -i /etc/apt/sources.list
RUN apt-get update && apt-get install -y software-properties-common python-software-properties
RUN add-apt-repository ppa:webupd8team/java -y

RUN apt-get update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

RUN apt-get install -y oracle-java7-installer

#Install GVM and Grails
ENV HOME /root
RUN curl -s get.gvmtool.net | bash &&\
    bash -c "source "~/.gvm/bin/gvm-init.sh" && yes y | gvm install grails 2.3.7 ; exit 0"

#Install Node
RUN git clone https://github.com/creationix/nvm.git /.nvm &&\
    echo ". /.nvm/nvm.sh" >> /etc/bash.bashrc &&\
    /bin/bash -c '. /.nvm/nvm.sh && nvm install v0.10.18 && nvm use v0.10.18 &&\
    nvm alias default v0.10.18 && ln -s /.nvm/v0.10.18/bin/node /usr/bin/node &&\
    ln -s /.nvm/v0.10.18/bin/npm /usr/bin/npm' &&\
    npm install forever -g

#Install Grunt
RUN npm install grunt@master -g &&\
    npm install grunt-cli -g &&\
    npm install grunt-init@master -g

ADD run.sh /usr/local/bin/run
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN chmod a+x usr/local/bin/run

RUN sed -i 's/^bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/my.cnf

EXPOSE 22 8080 8083

CMD ["/usr/local/bin/run"]