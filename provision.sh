#!/bin/bash

sudo yum install epel-release -y
echo "Inicio da Instalacao do Ansible"
sudo yum update -y
sudo yum install ansible -y
sudo yum install vim -y