#!/bin/bash
sudo yum update -y
sudo yum install python3 python3-pip -y
sudo yum install git -y
sudo yum install ansible -y
ansible-playbook Devops-Crypto/flask_run.yml
