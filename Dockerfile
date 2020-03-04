FROM docker:dind
RUN apk update
RUN apk add --no-cache git
RUN apk add --no-cache openssh
#RUN apk add --no-cache build-base
#RUN apk add --no-cache perl
#RUN apk add --no-cache python2
#RUN apk add --no-cache autoconf
#RUN apk add --no-cache boost-dev
#RUN apk add --no-cache automake
#RUN apk add --no-cache libtool
#RUN apk add --no-cache intltool
#RUN apk add --no-cache coreutils
#RUN apk add --no-cache gd-dev zlib-dev
RUN apk add --no-cache bash

ADD run.sh /elastic/run.sh

WORKDIR /elastic

RUN wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.6.0-linux-x86_64.tar.gz
RUN wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.6.0-linux-x86_64.tar.gz.sha512
RUN shasum -a 512 -c elasticsearch-7.6.0-linux-x86_64.tar.gz.sha512 
RUN tar -xzf elasticsearch-7.6.0-linux-x86_64.tar.gz -C elasticsearch
#RUN cd elasticsearch-7.6.0/
#RUN ./bin/elasticsearch

WORKDIR /elastic
RUN curl -O https://artifacts.elastic.co/downloads/kibana/kibana-7.6.0-linux-x86_64.tar.gz
RUN curl https://artifacts.elastic.co/downloads/kibana/kibana-7.6.0-linux-x86_64.tar.gz.sha512 | shasum -a 512 -c - 
RUN tar -xzf kibana-7.6.0-linux-x86_64.tar.gz -C kibana
#RUN cd kibana-7.6.0-linux-x86_64/ 
#RUN cd kibana-7.6.0-linux-x86_64/ 

ENTRYPOINT ["bash /elastic/run.sh"]

EXPOSE 9201 5601
LABEL maintainer="Allan Karlson <beesforever@gmx.de>"