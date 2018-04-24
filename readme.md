# NSQ's Container Ship

#### using docker compose create a NSQ environment

## Prepared before use

1. [Docker](https://docs.docker.com/engine/installation/) is installed. (include [docker-compose](https://docs.docker.com/compose/install/))

2. Make sure that host's ports are useable:
    * 4160
    * 4161
    * 4150
    * 4151
    * 4171

## How to use

### 1. Start container ship

```bash
ncs.sh start
```

### 2. Create topic

```bash
ncs.sh create topic 'topic1'
```

### 3. create channel

```bash
ncs.sh create channel 'topic1' 'channel1'
```

### 4. Open a new terminal, and create listener to listen the channel

```bash
ncs.sh listen 'topic1' 'channel1'
```

### 5. Send message to topic, and listener will recive the message

```bash
ncs.sh send 'topic1' 'this is a testing message.'

# send message by curl :
curl -d 'message' 'http://localhost:4151/pub?topic=topic1'
```

## tip

### 1. Auto start

##### This command will do "How to use" step.1 to step.4. (Topic: topic1/Channel: Channel1)

```bash
ncs.sh auto_start 'topic1' 'channel1'
```

### 2. Close or restart all container

```bash
ncs.sh stop
# or
ncs.sh restart
```

### 3. Show help

```bash
ncs.sh help
```

## GOlang connect code

```go
    // 建立「已接收」頻道，作為是否接收到訊息的一個開關。
	received := make(chan bool)
	// 建立空白設定檔。
	config := nsq.NewConfig()

	// 用該設定檔新建一個消費者建構體，然後表明要訂閱 `test` 主題，並訂閱該主題中的 `test_channel` 頻道。
	q, _ := nsq.NewConsumer("test", "test_channel", config)
	// 建立訊息接收函式，當我們接收到訊息就會呼叫這個函式。
	q.AddHandler(nsq.HandlerFunc(func(message *nsq.Message) error {
		// 顯示我們接收到的訊息。
        log.Printf("接收到了一個訊息：%v", string(message.Body))

		return nil
	}))

	// 連線到 NSQ 叢集，而不是單個 NSQ，這樣更安全與可靠。
    err := q.ConnectToNSQLookupd("lookup:4161")
    // 若要連線到 NSQd 參考如下
    // err := q.ConnectToNSQD("localhost:4150")
	if err != nil {
		log.Panic("連線失敗。")
	}

	// 除非接收到訊息，不然我們就讓程式卡住。
	<-received
```