FROM ubuntu:16.04

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-armhf
 
 
# install packages
RUN \
  apt-get update && apt-get install -y \
  ssh \
  rsync \
  vim inetutils-ping telnet\
  openjdk-8-jdk \
  wget libzip4 libsnappy1v5 libssl-dev && \
  rm -rf /var/lib/apt/lists/* 
  
WORKDIR /root
RUN wget http://mirrors.gigenet.com/apache/kafka/2.4.0/kafka_2.13-2.4.0.tgz \
  && tar -xvf kafka_2.13-2.4.0.tgz \
  && mv kafka_2.13-2.4.0 /opt/kafka \
  && rm -f kafka_2.13-2.4.0.tgz \
  && rm -f /opt/kafka/config/server.properties

ADD server.properties /opt/kafka/config/

WORKDIR /opt/kafka
EXPOSE 9092
