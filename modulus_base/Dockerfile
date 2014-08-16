FROM ubuntu:14.04
MAINTAINER Alexis DUQUE "alexis.duque@openmrs.org"

#Add universe repository and update
RUN echo "debconf debconf/frontend select Teletype" | debconf-set-selections &&apt-get -y update &&\
	apt-get -y install software-properties-common &&\
    add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe" &&\
    add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc)-updates main universe" 

RUN apt-get -y update &&\
    apt-mark hold initscripts &&\
    apt-get -y upgrade

#Install Mysql server
RUN apt-get -y update && apt-get install -y wget mysql-server

#Create modulus user
RUN useradd modulus -s /bin/bash -m -U

#Download and setup Java Oracle JDK7
RUN wget --progress=bar --no-check-certificate -O /tmp/server-jre-7u51-linux-x64.tar.gz --header "Cookie: oraclelicense=a" http://download.oracle.com/otn-pub/java/jdk/7u51-b13/server-jre-7u51-linux-x64.tar.gz

RUN echo "c5a034f4222bac326101799bcb20509c  /tmp/server-jre-7u51-linux-x64.tar.gz" | md5sum -c > /dev/null 2>&1 || echo "ERROR: MD5SUM MISMATCH"
RUN tar xzf /tmp/server-jre-7u51-linux-x64.tar.gz 
RUN mkdir -p /usr/lib/jvm/java-7-oracle 
RUN mv jdk1.7.0_51/jre /usr/lib/jvm/java-7-oracle/jre 
RUN rm -rf jdk1.7.0_51 && rm /tmp/server-jre-7u51-linux-x64.tar.gz
RUN chown root:root -R /usr/lib/jvm/java-7-oracle
RUN update-alternatives --install /usr/bin/java java /usr/lib/jvm/java-7-oracle/jre/bin/java 1
RUN update-alternatives --set java /usr/lib/jvm/java-7-oracle/jre/bin/java

ADD start.sh /usr/local/bin/run
RUN chmod a+x usr/local/bin/run

RUN sed -i 's/^bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/my.cnf

CMD ["/usr/local/bin/run"]