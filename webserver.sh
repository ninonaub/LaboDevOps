#!/usr/bin/env bash
 
# BEGIN ########################################################################
echo -e "-- ----------------- --\n"
echo -e "-- BEGIN ${HOSTNAME} --\n"
echo -e "-- ----------------- --\n"
 
# VARIABLES ####################################################################
echo -e "-- Setting global variables\n"
APACHE_CONFIG=/etc/apache2/apache2.conf
LOCALHOST=localhost
 
# BOX ##########################################################################
echo -e "-- Updating packages list\n"
sudo apt-get update &> /dev/null
sudo apt-get upgrade -y &> /dev/null
echo -e "-- Updating git list\n"
sudo apt-get install -y git-core &> /dev/null

# APACHE #######################################################################
echo "Installating Apache 2...\n"
sudo apt install -y apache2 &> /dev/null
sudo a2enmod rewrite headers expires &> /dev/null

echo -e "-- Installing php \n"
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://packages.sury.org/php/apt.gpg | sudo apt-key add -
sudo add-apt-repository "deb https://packages.sury.org/php/ $(lsb_release -cs) main"
sudo apt update 
sudo apt install -y php7.2-common php7.2-cli
sudo systemctl restart apache2 &> /dev/null
echo -e "-- Restarting Apache web server\n"




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

# WOPRDPRESS ###################################################################
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

sudo chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp
wp --info


# wp core download

sudo rm /var/www/html/index.html
sudo -u vagrant -i -- wp core download --path=/var/www/html
# wp config
echo "Testing*************************************\n"
cd /var/www/html
#sudo -u vagrant -i -- wp config create --dbname=wpvagrant --dbuser=ad10 --dbpass=0000 --path=/var/www/html 
sudo -u root -i -- wp config create --dbname=wpvagrant --dbuser=root --dbpass=0000 --path=/var/www/html --allow-root
sudo -u root -i -- wp db create --dbuser=root --dbpass=0000 --path=/var/www/html --allow-root
cat << EOT >>  /var/www/html/phpinfo.php
<?php
phpinfo();
?>
EOT
#sudo -u root -i -- wp core install --url=/var/www/html --path=/var/www/html --title="WP-CLI" --admin_user=vagrant --admin_password=vagrant --admin_email=test@wp-cli.org --allow-root
sudo -u vagrant -i -- wp plugin update --all --path=/var/www/html 


echo "Configuration de SSH\n"
sudo sed -e '/PasswordAuthentication no/ s/^#*/#/' -i /etc/ssh/sshd_config
sudo systemctl restart sshd
 
# END ##########################################################################
echo -e "-- -------------- --"
echo -e "-- END ${HOSTNAME} --"
echo -e "-- -------------- --"
