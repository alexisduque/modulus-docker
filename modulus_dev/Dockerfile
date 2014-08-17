FROM openmrs/modulus:base
MAINTAINER Alexis DUQUE "alexis.duque@openmrs.org"

RUN mkdir /opt/modulus &&\
    mkdir /opt/modulus-ui

ADD modulus-config.properties /root/.grails/modulus-config.properties

RUN git clone https://github.com/openmrs/openmrs-contrib-modulus.git /opt/modulus
RUN git clone https://github.com/openmrs/openmrs-contrib-modulus-ui.git /opt/modulus-ui

RUN cd /opt/modulus && git submodule update --init

RUN cd /opt/modulus-ui && npm install
RUN cd /opt/modulus-ui && grunt build

RUN sed -i 's#/modulus#http://localhost:8080#g' /opt/modulus-ui/config/modulusui.conf.js

ADD run.sh /usr/local/bin/run
RUN chmod a+x usr/local/bin/run

CMD ["/usr/local/bin/run"]