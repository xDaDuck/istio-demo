#!/usr/bin/env bash

basedir=$(dirname $0)
rootdir=${basedir}/..

istio-apply(){
        kubectl apply -f <( istioctl kube-inject -f $@ )
}

istio-apply ${basedir}/demo-v1.yaml
istio-apply ${basedir}/sleep.yaml

istio-apply ${basedir}/demo-sa.yaml
istio-apply ${basedir}/demo-svc.yaml
istio-apply ${basedir}/demo-vs.yaml
istio-apply ${basedir}/demo-dr.yaml
