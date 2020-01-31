#!/usr/bin/env bash

basedir=$(dirname $0)
rootdir=${basedir}/..

if [[ "$1" == "-m" ]]; then
  echo "setup microk8s kubectl & istioctl"
  kubectl() {
    microk8s.kubectl $@
  }

  istioctl() {
    microk8s.istioctl $@
  }
fi

istio-apply(){
  kubectl apply -f <( istioctl kube-inject -f $@ )
}

kubectl delete -f sleep.yaml
kubectl delete -f proxy.yaml
kubectl delete -f proxy-istio.yaml
kubectl delete -f wikipedia.yaml

kubectl apply -f wikipedia.yaml
istio-apply ${basedir}/sleep.yaml

kubectl apply -f proxy.yaml

PROXY_PORT=3128

while [[ -z "$PROXY_IP" ]]; do
  PROXY_IP=$(kubectl get pod -n external -l app=squid -o jsonpath={.items..podIP})
done

cat proxy-istio.yaml | sed -r "s/<ADDRESS>/$PROXY_IP/" | microk8s.kubectl apply -f-

echo -e "\e[33madd proxy"
echo -e "export PROXY=${PROXY_IP}:${PROXY_PORT}\e[0m"
