#!/bin/bash
managerIP=$(grep manager /etc/hosts | tail -n 1 | awk '{print $1}');

if [[ `hostname` = manager01 ]]; then
    rFlag="init --listen-addr";
else
    rFlag="join";
fi

echo "docker swarm $rFlag ${managerIP}:2377"
docker swarm $rFlag ${managerIP}:2377
