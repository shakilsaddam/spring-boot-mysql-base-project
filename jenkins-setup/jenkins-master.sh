#!/bin/bash

# Update hosts file
echo "[TASK 1] Update /etc/hosts file"
cat >>/etc/hosts<<EOF
192.168.57.200 jenkins.example.com jenkinsserver
192.168.57.100 kubmaster.example.com kubmaster
192.168.57.101 kubeworker1.example.com kubeworker1
192.168.57.102 kubeworker2.example.com kubeworker2
EOF

echo "[Task2] Install docker container engine"
apt-get install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update -y
apt-get install docker-ce -y

# add ccount to the docker group
usermod -aG docker vagrant

# Enable docker service
echo "[TASK 3] Enable and start docker service"
systemctl enable docker >/dev/null 2>&1
systemctl start docker

echo "[Task 4] Adding apt-keys of Jenkins"
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
echo deb https://pkg.jenkins.io/debian binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list

echo "Updating apt-get"
sudo apt-get -qq update && sudo apt-get -qq upgrade

#jenkins requires Java 8 or 11
echo "[Task 5] Installing openjdk-8-jre, openjdk-8-jdk and then jenkins"
sudo apt-get -y -q install openjdk-8-jre openjdk-8-jdk jenkins 

#echo "Installing jenkins 2.222"
#wget -q "http://pkg.jenkins-ci.org/debian-stable/binary/jenkins_2.222.4_all.deb"  
#sudo apt-get -y install ./jenkins_2.222.4_all.deb
#rm -f ./jenkins_2.222.4_all.deb

echo "Starting Jenkins"
sudo service jenkins start
sleep 1m