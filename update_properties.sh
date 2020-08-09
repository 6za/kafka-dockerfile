#!/bin/bash
config_file=/opt/kafka/config/server.properties
config_temp_file=/opt/kafka/config/server.temp.properties
config_live_file=/opt/kafka/config/server.live.properties
cp $config_file $config_temp_file
#export KAFKA_ADVERTISED_LISTENERS="testeADV"
#export KAFKA_ZOOKEEPER_CONNECT="testeZC"
#export KAFKA_LISTENERS="testeL"

CHANGED=false
if [ -z ${KAFKA_ADVERTISED_LISTENERS+x} ]; then echo "KAFKA_ADVERTISED_LISTENERS is unset"; 
else 
    CHANGED=true
    sed -i '/^advertised.listeners[[:blank:]]*=/d' $config_temp_file
    echo "KAFKA_ADVERTISED_LISTENERS is set to '$KAFKA_ADVERTISED_LISTENERS'"; 
    printf "\nadvertised.listeners=$KAFKA_ADVERTISED_LISTENERS" >> $config_temp_file
fi

if [ -z ${KAFKA_ZOOKEEPER_CONNECT+x} ]; then echo "KAFKA_ZOOKEEPER_CONNECT is unset"; 
else 
    CHANGED=true
    sed -i '/^zookeeper.connect[[:blank:]]*=/d' $config_temp_file
    echo "KAFKA_ZOOKEEPER_CONNECT is set to '$KAFKA_ZOOKEEPER_CONNECT'"; 
    printf "\nzookeeper.connect=$KAFKA_ZOOKEEPER_CONNECT" >> $config_temp_file
fi

if [ -z ${KAFKA_LISTENERS+x} ]; then echo "KAFKA_LISTENERS is unset"; 
else 
    CHANGED=true    
    sed -i '/^listeners[[:blank:]]*=/d' $config_temp_file
    echo "KAFKA_LISTENERS is set to '$KAFKA_LISTENERS'"; 
    printf "\nlisteners=$KAFKA_LISTENERS" >> $config_temp_file

fi


if $CHANGED; then 
    echo "CHANGED is true - use temp file"; 
    mv $config_temp_file $config_live_file
    diff $config_file  $config_live_file & echo 0
else 
    echo "CHANGED is false - use original"; 
    cp $config_file $config_live_file
fi
