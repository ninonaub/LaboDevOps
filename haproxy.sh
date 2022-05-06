#!/usr/bin/env bash
 
# BEGIN ########################################################################
echo -e "-- ------------- --\n"
echo -e "-- BEGIN HAPROXY --\n"
echo -e "-- ------------- --\n"
 
# BOX ##########################################################################
echo -e "-- Updating packages list\n"
apt-get update -y -qq
 
# HAPROXY ######################################################################
echo -e "-- Installing HAProxy\n"
sudo apt -y install haproxy 
 
echo -e "-- Enabling HAProxy as a start-up deamon\n"
cat > /etc/default/haproxy <<EOF
ENABLED=1
EOF
 
echo -e "-- Configuring HAProxy\n"
cat > /etc/haproxy/haproxy.cfg <<EOF
global
    log /dev/log local0
    log localhost local1 notice
    user haproxy
    group haproxy
    maxconn 2000
    daemon
 
defaults
    log global
    mode http
    option httplog
    option dontlognull
    retries 3
    timeout connect 5000
    timeout client 50000
    timeout server 50000
 
frontend http-in
    bind *:80
    default_backend webservers
 
backend webservers
    balance roundrobin
    stats enable
    stats auth admin:admin
    stats uri /haproxy?stats
    option httpchk
    option forwardfor
    option http-server-close
    server webserver1 192.168.50.10:80 check
    server webserver2 192.168.50.20:80 check


EOF

# frontend ssh-in
#     bind *:2222
#     default_backend dbservers
 
# backend dbservers
#     balance roundrobin
#     stats enable
#     stats auth admin:admin
#     stats uri /haproxy?stats
#     mode tcp
#     server dbserver1 192.168.50.40:22 check


echo -e "-- Validating HAProxy configuration\n"
haproxy -f /etc/haproxy/haproxy.cfg -c
 
echo -e "-- Starting HAProxy\n"
sudo systemctl restart haproxy
 
# END ##########################################################################
echo -e "-- ----------- --"
echo -e "-- END HAPROXY --"
echo -e "-- ----------- --"