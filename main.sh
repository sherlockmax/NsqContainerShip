#!/bin/bash

#!/bin/bash

SELF_PATH=${BASH_SOURCE[0]}
if [[ -L "$SELF_PATH" ]]
then
    DIR=$(dirname $(readlink ${SELF_PATH}))
else
    DIR=$(dirname  ${SELF_PATH})
fi

source $DIR/function.sh

mainCommand=$1
subCommand=${2-}

case "$mainCommand" in
    start)
        cd $DIR/docker;
        startCompose;;
    stop)
        cd $DIR/docker;
        stopCompose;;
    restart)
        cd $DIR/docker;
        stopCompose;
        startCompose;;
    create)
        case "$subCommand" in
            topic)
                createTopic ${@:3};;
            channel)
                createChannel ${@:3};;
            *|help)
                callHelp;;
        esac;;
    send)
        sendMessage $subCommand;;
    listen)
        listen $subCommand;;
    *|help)
        callHelp;;
esac


#docker rm -f nsqlookupd
#docker rm -f nsqd
#docker rm -f nsqadmin
#docker network rm nsq

# create network
#docker network create nsq

# start lookup
#docker run -d --net=nsq -p 4160:4160 -p 4161:4161 --name nsqlookupd nsqio/nsq /nsqlookupd

# start nsqd and set address
#docker run -d --net=nsq -p 4150:4150 -p 4151:4151 --name nsqd nsqio/nsq /nsqd --lookupd-tcp-address=nsqlookupd:4160

# start nsqadmin
#docker run -d --net=nsq --name nsqadmin -p 4171:4171 nsqio/nsq /nsqadmin --lookupd-http-address=nsqlookupd:4161

# create topic
#curl -X POST "http://127.0.0.1:4151/topic/create?topic=default"

#create channel
#curl -X POST "http://127.0.0.1:4151/channel/create?topic=default&channel=test"

# start consumers - nsq to tail
#docker run --net=nsq --name nsqtail nsqio/nsq /nsq_tail --topic=default --channel=test --lookupd-http-address=nsqlookupd:4161