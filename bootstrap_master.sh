#!/bin/bash

echo "[TASK 1] Pull required containers"
#kubeadm config images pull >/dev/null

echo "[TASK 2] Initialize Kubernetes Cluster"
kubeadm init --apiserver-advertise-address=172.16.16.100 --pod-network-cidr=192.168.0.0/16 >> /root/kubeinit.log 2>/dev/null

# Copy Kube admin config
echo "[TASK 2a] Copy kube admin config to Vagrant user .kube directory"
mkdir /home/vagrant/.kube
cp /etc/kubernetes/admin.conf /home/vagrant/.kube/config
chown -R vagrant:vagrant /home/vagrant/.kube

#echo "[TASK 3] Deploy Calico network"
#kubectl --kubeconfig=/etc/kubernetes/admin.conf create -f https://raw.githubusercontent.com/projectcalico/calico/v3.27.0/manifests/tigera-operator.yaml >/dev/null
#kubectl --kubeconfig=/etc/kubernetes/admin.conf create -f https://raw.githubusercontent.com/projectcalico/calico/v3.27.0/manifests/custom-resources.yaml >/dev/null

#echo "[TASK 3] Install Helm"
#curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
#chmod 700 get_helm.sh
#./get_helm.sh

#echo "[TASK 4] Deploy Cilium"
#helm repo add cilium https://helm.cilium.io/
#helm repo update
#helm install cilium cilium/cilium --version 1.11.1 --namespace kube-system \
   # --set hubble.relay.enabled=true \
   # --set hubble.ui.enabled=true
#kubectl port-forward -n kube-system svc/hubble-ui 8080:80


echo "[TASK 5] Generate and save cluster join command to /joincluster.sh"
#mkdir /srv/join
kubeadm token create --print-join-command > /srv/join/joincluster.sh
