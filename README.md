# CCA Research: Cubic & BBR


Firstly, considering that senders and receivers are located within distinct subnets and connected by a router, create two such subnets using the following commands:

```
docker network create --subnet=192.168.1.0/24 sender_network
docker network create --subnet=192.168.2.0/24 receiver_network
```

After building docker images of TCP sender, TCP receiver, and router in corresponding folders, we can start building the network by running containers. TCP receivers and the router can be long-running:

```
# start tcp receiver
docker run -d --rm --name cubic_receiver --network receiver_network --ip 192.168.2.2 tcp-receiver:latest
docker run -d --rm --name bbr_receiver --network receiver_network --ip 192.168.2.3 tcp-receiver:latest

# start router
docker run -d --rm --name send2recv --network sender_network --ip 192.168.1.4 --privileged router:latest
docker network connect --ip 192.168.2.4 receiver_network send2recv
```

TCP senders need to be terminated right after collecting all the statistics, otherwise the running containers will consume too much CPU and disk resources. CCA can be determined at the runtime.

```
# start tcp sender of cubic or bbr
docker run -d --rm --name cubic_sender --network sender_network --ip 192.168.1.2 --privileged tcp-sender:latest
docker run -d --rm --name bbr_sender --network sender_network --ip 192.168.1.3 --privileged -e TCP_CONGESTION_CONTROL=bbr tcp-sender:latest

# collect cwnd statistics and stop the container
docker cp cubic_sender:/cwnd_log.csv ./cwnd_log.csv && docker stop cubic_sender
```

Finally, don't forget to rebuild the images when making changes to the source code. (Is there a Git-like tool to remind people that the source code has changed?)
