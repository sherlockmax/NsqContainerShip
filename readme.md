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
ncs.sh auto_start
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
