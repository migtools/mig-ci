#!/bin/bash

if [ -f /bin/podman ]
then
  podman --version
else
  sudo yum install -y podman
fi

# map range of namespaces for jenkins user
#in order to run containers rootless
sudo sysctl user.max_user_namespaces=100000
echo "jenkins:100000:65536" >> /etc/subuid
echo "jenkins:100000:65536" >> /etc/subgid

# some cleanup to avoid errors
podman stop $(podman ps -q)
rm /tmp/run-996/libpod/pause.pid
