#!/usr/bin/env bash
 
# BEGIN ########################################################################
echo -e "-- ------------- --\n"
echo -e "- BEGIN DB SERVER -\n"
echo -e "-- ------------- --\n"
 
# BOX ##########################################################################
echo -e "-- Updating packages list\n"
sudo apt update &> /dev/null
sudo apt upgrade -y &> /dev/null

echo "Installing Git...\n"
sudo apt install -y git-core &> /dev/null

echo "Installing MariaDb..."
sudo apt install -y software-properties-common dirmngr &> /dev/null
export DEBIAN_FRONTEND=noninteractive
sudo debconf-set-selections <<< 'mariadb-server mysql-server/root_password password 0000'
sudo debconf-set-selections <<< 'mariadb-server mysql-server/root_password_again password 0000'
sudo -E apt install -y mariadb-server &> /dev/null
sudo mysql -uroot -p0000 -e  "CREATE DATABASE ad10;"
sudo mysql -uroot -p0000 -e  "CREATE USER 'ad10' IDENTIFIED BY '0000';"
sudo mysql -uroot -p0000 -e "GRANT USAGE ON *.* TO 'ad10'@localhost IDENTIFIED BY '0000';"
sudo mysql -uroot -p0000 -e "GRANT ALL privileges ON ad10.* TO 'ad10'@localhost;"
sudo mysql -uroot -p0000 -e  "FLUSH PRIVILEGES;"
echo "Le mot de passe root de MariaDb est : 0000"
echo "La base de données 'ad10' a été créée"
echo "L'utilisateur MariaDB 'ad10' a été créé"
echo "Le mot de passe de l'utilisateur MariaDb 'ad10' est : 0000 \n"

echo "Configuration de SSH\n"
sudo sed -e '/PasswordAuthentication no/ s/^#*/#/' -i /etc/ssh/sshd_config
sudo systemctl restart sshd

echo "Installation terminée. Connectez-vous avec la commande vagrant ssh\n"
