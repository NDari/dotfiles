#!/usr/bin/env bash

IP=$1
SERVER=ec2-user@$IP
PEMFILE=${2:-"$HOME/lkdjfs-EMR.pem"}

ssh -i $PEMFILE $SERVER mkdir -p .ssh
ssh -i $PEMFILE $SERVER mkdir -p .aws
cat ~/.ssh/id_rsa.pub | ssh -i $PEMFILE $SERVER 'cat >> .ssh/authorized_keys'
cat ~/.aws/credentials | ssh -i $PEMFILE $SERVER 'cat >> .aws/credentials'
