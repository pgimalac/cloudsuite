#!/bin/sh

# number of slaves
nbslaves=5

master="master"
slaves=$(seq -w 1 $nbslaves | sed 's/^/slave/')
all=$(echo $master; echo $slaves)

# build hadoop docker image
(cd ../../../commons/hadoop/2.10.1 && docker build -t hadoop .)
# build data-analytics docker image
docker build -t data-analytics .

docker network create hadoop-net

# start docker containers
docker run -d --net hadoop-net --name master --hostname master data-analytics master
echo slaves | parallel 'docker run -d --net hadoop-net --name {} --hostname {} hadoop slave'

# run benchmark
docker exec master strace -ff -tt -o strace.out benchmark

# merge straces and copy merged result locally
echo all | parallel 'docker cp ../../strace-merge.sh {}: ; docker exec {} sh strace-merge.sh ; docker cp {}:strace.out strace.{}.out'
