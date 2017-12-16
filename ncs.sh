#!/bin/bash

SELF_PATH=${BASH_SOURCE[0]}
if [[ -L "$SELF_PATH" ]]
then
    DIR=$(dirname $(readlink ${SELF_PATH}))
else
    DIR=$(dirname  ${SELF_PATH})
fi

source $DIR/function.sh

case "$1" in
    start)
        cd $DIR/nsq
        startCompose;;
    stop)
        cd $DIR/nsq
        stopCompose;;
    restart)
        cd $DIR/nsq
        stopCompose
        startCompose;;
    auto_start)
        cd $DIR/nsq
        stopCompose
        startCompose
        echo "create topic named: topic1"
        createTopic 'topic1'
        echo "create channel in 'topic1' named: channel1"
        createChannel 'topic1' 'channel1'
        echo "listen topic1/channel1"
        listen 'topic1' 'channel1';;
    create)
        case "$2" in
            topic)
                createTopic ${@:3};;
            channel)
                createChannel ${@:3};;
            *|help)
                callHelp;;
        esac;;
    send)
        sendMessage ${@:2};;
    listen)
        listen ${@:2};;
    self_update)
        git checkout .
        git remote update -p
        git pull origin master;;
    *|help)
        callHelp;;
esac