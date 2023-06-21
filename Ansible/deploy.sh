#!/bin/bash
sudo yum update -y
sudo yum install python3 python3-pip -y
sudo yum install git -y
sudo pip install ansible
ansible-playbook /home/ec2-user/Ansible/flask_run.yml
