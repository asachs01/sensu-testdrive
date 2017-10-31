#!/bin/sh
IPADDR=$(/sbin/ip -o -4 addr list enp0s8  | awk '{print $4}' | cut -d/ -f1)

# Make sure we have all the package repos we need!
 sudo yum install epel-release vim yum-utils openssl -y

# Set up zero-dependency erlang
echo ' [rabbitmq-erlang]
name=rabbitmq-erlang
baseurl=https://dl.bintray.com/rabbitmq/rpm/erlang/20/el/7
gpgcheck=1
gpgkey=https://www.rabbitmq.com/rabbitmq-release-signing-key.asc
repo_gpgcheck=0
enabled=1' | sudo tee /etc/yum.repos.d/rabbitmq-erlang.repo
 sudo yum install erlang -y

# Install rabbitmq
 sudo yum install https://dl.bintray.com/rabbitmq/rabbitmq-server-rpm/rabbitmq-server-3.6.12-1.el7.noarch.rpm -y

# Set up Sensu's repository & Sensu Enterprise
echo '[sensu]
name=sensu
baseurl="https://repositories.sensuapp.org/yum/$releasever/$basearch/"
gpgcheck=0
enabled=1' | sudo tee /etc/yum.repos.d/sensu.repo

# Get Redis installed
 sudo yum install redis -y

# Install Sensu itself
 sudo yum install sensu uchiwa -y

# Provide minimal transport configuration (used by client, server and API)
 echo '{
  "transport": {
    "name": "rabbitmq"
  }
}' | sudo tee /etc/sensu/transport.json

# provide minimal client configuration
 echo "{
 \"client\": {
   \"address\": \"$IPADDR\",
   \"environment\": \"development\",
   \"subscriptions\": [
     \"dev\"
   ]
 }
}" |sudo tee /etc/sensu/conf.d/client.json

# Ensure config file permissions are correct
 sudo chown -R sensu:sensu /etc/sensu

# Install curl and jq helper utilities
 sudo yum install curl jq -y

# Provide minimal uchiwa conifguration, pointing at API on localhost
  echo '{
  "sensu": [
    {
      "name": "sensu",
      "host": "127.0.0.1",
      "port": 4567
    }
  ],
  "uchiwa": {
    "host": "0.0.0.0",
    "port": 3000
  }
 }' |sudo tee /etc/sensu/uchiwa.json

# Configure sensu to use SSL
echo '{
  "rabbitmq": {
    "host": "127.0.0.1",
    "port": 5672,
    "vhost": "/sensu",
    "user": "sensu",
    "password": "secret",
    "heartbeat": 30,
    "prefetch": 50
  }
}' | sudo tee /etc/sensu/conf.d/rabbitmq.json

# Configure minimal Redis configuration for Sensu

echo '{
  "redis": {
    "host": "127.0.0.1",
    "port": 6379
  }
}' | sudo tee /etc/sensu/conf.d/redis.json

# Start up rabbitmq services
sudo systemctl start rabbitmq-server

# Add rabbitmq vhost configurations
sudo rabbitmqctl add_vhost /sensu
sudo rabbitmqctl add_user sensu secret
sudo rabbitmqctl set_permissions -p /sensu sensu ".*" ".*" ".*"

#Start up other services
sudo systemctl start sensu-{server,api,client}.service
sudo systemctl start redis.service
sudo systemctl start uchiwa
sudo systemctl enable uchiwa
sudo systemctl enable redis.service
sudo systemctl enable rabbitmq-server
sudo systemctl enable sensu-{server,api,client}.service

echo -e "=================
Sensu is now up and running!
Access it at $IPADDR:3000
================="
