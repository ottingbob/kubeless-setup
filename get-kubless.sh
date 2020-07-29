#!/bin/sh

# Install Kubeless CLI
apt install unzip -y
wget https://github.com/kubeless/kubeless/releases/download/v1.0.6/kubeless_linux-amd64.zip
unzip kubeless_linux-amd64.zip
mv bundles/kubeless_linux-amd64/kubeless /usr/local/bin
rm -r bundles/

# Deploy kubeless
kubectl create ns kubeless
kubectl create -f https://github.com/kubeless/kubeless/releases/download/v1.0.6/kubeless-non-rbac-v1.0.6.yaml
https://github.com/kubeless/kubeless/releases/download/v1.0.6/kubeless-v1.0.6.yaml

###===========================
# Example function(s)
#
# python example
kubeless function deploy hello --runtime python3.7 \
  --from-file python-example/example.py \
  --handler test.hello

#
# nodejs exapmle
kubeless function deploy myFunction --runtime nodejs12.8 \
  --dependencies node-example/package.json \
  --handler test.myFunction \
  --from -file node-example/example.js

###===========================
# Kubeless function commands
#
# list the functions
kubeless function ls

#
# call a funciton
kubeless function call hello --data 'clown'


# First we need to change the service created `hello`
# to be able to expose port 80 for the nginx-ingress
# helm chart with cert manager to be able to  certify 
# for https traffic
kc edit svc hello
# Change .spec.ports['http-function-port'].port to 80
# > ports:
# > - name: http-function-port
# >   port: 80
# >   protocol: TCP
# >   targetPort: 8080

#
# deploy a function
kubeless trigger http create hello \
  --function-name hello \
  --hostname <hostname>

# This will deploy both an `httptrigger` object as
# well as an `ingress` object. We need to modify the
# `httptrigger` object to support the hostname we want
# configured for this function
# .... Explain tls secret name and annotations ...

curl https://<hostname> -d 'clowning' && echo
# > 'clowning'