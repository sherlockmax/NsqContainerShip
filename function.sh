function callHelp {
    echo "指令: main.sh {命令} [參數]"
    cat <<EOF
start...........啟動nsq
stop............停止nsq
restart.........重新啟動nsq
update..........自我更新
create..........
    topic.......建立新主題(使用：main.sh create topic [主題名稱])
    channel.....於指定的主題建立新頻道(使用：main.sh create topic [主題名稱] [頻道名稱])
help............指令說明
*...............指令說明

EOF
    exit 0
}

function startCompose {
    docker-compose up -d
    echo "啟動完成..."
    echo "前往監控介面：http://localhost:4171/"
}

function stopCompose {
    docker-compose down
}

function createTopic {
    topic=${1}
    curl -X POST "http://127.0.0.1:4151/topic/create?topic=$topic"
}

function createChannel {
    topic=${1}
    channel=${2}
    curl -X POST "http://127.0.0.1:4151/channel/create?topic=$topic&channel=$channel"
}

function sendMessage {
    topic=${1}
    message=${2}
    curl -d "$message" "http://127.0.0.1:4151/put?topic=$topic"
}

function listen {
    topic=${1}
    channel=${2}
    docker run --name nsqtail --link=docker_nsqlookupd_1:lookup nsqio/nsq /nsq_tail --topic="$topic" --channel="$channel" --lookupd-http-address=nsqlookupd:4161
}