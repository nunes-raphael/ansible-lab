#!/bin/bash
yes | ssh-keygen -b 2048 -t rsa -f /home/vagrant/.ssh/id_rsa -q -N ""
cp -f /home/vagrant/.ssh/id_rsa.pub /vagrant
chmod 600 /vagrant/id_rsa.pub