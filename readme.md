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

### 1. start container ship

```bash
main.sh start
```

### 2. create topic

```bash
main.sh create topic "topic1"
```

### 3. create channel

```bash
main.sh create channel "topic1" "channel1"
```

### 4. open a new terminal, and create listener to listen the channel

```bash
main.sh listen "topic1" "channel1"
```

### 5. send message to topic, and listener will recive the message

```bash
main.sh send "topic1" "this is a testing message."

# send message by curl : 
curl -d "message" "http://localhost:4151/pub?topic=topic1"
```

## tip

### 1. show help

```bash
main.sh help
```

### 2. close or restart all container

```bash
main.sh stop
# or
main.sh restart
```