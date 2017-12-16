function callHelp {
    echo "指令: nsc.sh {命令} [參數]"
    cat <<EOF
    
start...........啟動nsq container ship
                指令: nsc.sh start
stop............停止nsq container ship
                指令: nsc.sh stop
restart.........重新啟動nsq container ship
                指令: nsc.sh restart
create topic....建立新主題(topic)
                指令: nsc.sh create topic [:主題名稱]
create channel..於指定的主題(topic)中建立新頻道(channel)
                指令: nsc.sh create topic [:主題名稱] [:頻道名稱]
send............傳送訊息到指定的主題(topic)
                指令: nsc.sh send [:主題名稱] [:訊息]
listen..........監聽指定的主題(topic)頻道(channel)的訊息，若只給主題(topic)則會自己建立一個新的頻道並監聽
                指令: nsc.sh listen [:主題名稱] [頻道名稱]
self_update.....nsq container ship的自我版本更新
                指令: nsc.sh self_update [:主題名稱] [頻道名稱]
help............使用說明
                指令: nsc.sh help

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
    curl -X POST "http://localhost:4151/topic/create?topic=$topic"
}

function createChannel {
    topic=${1}
    channel=${2}
    curl -X POST "http://localhost:4151/channel/create?topic=$topic&channel=$channel"
}

function sendMessage {
    topic=${1}
    message=${2}
    curl -d "$message" "http://localhost:4151/pub?topic=$topic"
}

function listen {
    topic=${1}
    channel=${2}
    docker exec listen nsq_tail --topic=$topic --channel=$channel --lookupd-http-address=lookup:4161
}