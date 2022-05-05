#!/bin/bash

echo "Configuration de SSH\n"
# sudo sed -e 's/PasswordAuthentication yes/PasswordAuthentication no/g' -i /etc/ssh/sshd_config
# sed -i 's/Port 22/Port 37271/gI' /etc/ssh/sshd_config
# sudo sed -i -e '$aPort 37271'  /etc/ssh/sshd_config

cat << EOT >>  /etc/ssh/sshd_config
# Supported HostKey algorithms by order of preference.
HostKey /etc/ssh/ssh_host_ed25519_key
HostKey /etc/ssh/ssh_host_ecdsa_key
HostKey /etc/ssh/ssh_host_rsa_key

# Password based logins are disabled - only public key based logins are allowed.
AuthenticationMethods publickey

# LogLevel VERBOSE logs user's key fingerprint on login. Needed to have a clear audit track of which key was using to log in.
LogLevel VERBOSE

# PermitRootLogin no

# Log sftp level file access (read/write/etc.) that would not be easily logged otherwise.
Subsystem sftp  /usr/lib/ssh/sftp-server -f AUTHPRIV -l INFO
EOT

cat /etc/ssh/sshd_config
sudo systemctl restart sshd

echo "Installation terminée. Connectez-vous avec la commande vagrant ssh\n"
