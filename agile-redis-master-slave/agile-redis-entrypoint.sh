#!/bin/bash

CONF_FILE=/etc/redis/redis.conf

if [ ! -f $CONF_FILE ]
then
    echo "appendonly yes" > $CONF_FILE
    echo "masterauth McjN2UhLrwrDKf" >> $CONF_FILE   
    echo "requirepass McjN2UhLrwrDKf" >> $CONF_FILE   

    if [ -n "$REDIS_MASTER_HOST" ]
    then
        echo "slaveof redis-master 6379" > $CONF_FILE
        echo "replica-announce-ip ${REDIS_SLAVE_HOST}" >> $CONF_FILE
    else 
        echo "replica-announce-ip redis-master" >> $CONF_FILE
    fi
    chown redis:redis $CONF_FILE
fi

exec docker-entrypoint.sh redis-server /etc/redis/redis.conf