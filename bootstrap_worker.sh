#!/bin/bash

echo "[TASK 1] Join node to Kubernetes Cluster"
export DEBIAN_FRONTEND=noninteractive
bash /srv/join/joincluster.sh 
