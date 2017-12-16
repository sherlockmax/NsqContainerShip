# NSQ's Container Ship 

### using docker compose create a nsq environment

# Prepared before use 事前準備

1. [Docker](https://docs.docker.com/engine/installation/) is installed. (include [docker-compose](https://docs.docker.com/compose/install/))

2. Make sure that host's ports are useable:
    * 4160
    * 4161
    * 4150
    * 4151
    * 4171 

# How to use

## 1. start container ship

```
.\main.sh start
```

## 2. create topic

```
.\main.sh create topic "topic1"

# or you can create by admin page (http://localhost:4171/lookup)
```

## 3. create channel

```
.\main.sh create channel "topic1" "channel1"

# or you can create by admin page (http://localhost:4171/lookup)
```

## 4. open a new terminal, and create listener to listen the channel

```
.\main.sh listen "topic1" "channel1"
```

## 5. send message to topic, and listener will recive the message

```
.\main.sh send "topic1" "this is a testing message."
```

# tip

## 1. show help

```
.\main.sh help
```

## 2. close or restart all container

```
.\main.sh stop
# or
.\main.sh restart
```