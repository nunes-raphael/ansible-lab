#!/bin/bash

sudo cat /vagrant/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
sudo chmod 600 /home/vagrant/.ssh/authorized_keys