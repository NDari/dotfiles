#!/usr/bin/env bash

SERVER=$1

ssh -i ~/AWS-datascience-EMR.pem $SERVER mkdir -p .ssh
cat ~/.ssh/id_rsa.pub | ssh -i ~/AWS-datascience-EMR.pem $SERVER 'cat >> .ssh/authorized_keys'
