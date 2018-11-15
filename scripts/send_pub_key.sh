#!/usr/bin/env bash

SERVER=$1
PEMFILE=$2

ssh -i $PEMFILE $SERVER mkdir -p .ssh
cat ~/.ssh/id_rsa.pub | ssh -i $PEMFILE $SERVER 'cat >> .ssh/authorized_keys'
