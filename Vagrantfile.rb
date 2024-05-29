# -*- mode: ruby -*-
Vagrant.configure("2") do |config|
  config.vm.box = "generic/debian12"
  config.vm.hostname = "ludo-glpi"
  config.vm.network "private_network", type: "static", ip: "192.168.44.11"
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 2
  end
  config.vm.provision "shell", inline: <<-SHELL
  # Install sed
  sudo apt-get install -y sed
  # install gnupg2
  sudo apt-get install -y gnupg2
  # Install update
  sudo apt-get update -y
  # Install OpenSSH server
  sudo apt-get install -y openssh-server
  # Configure SSH
  sudo mkdir /root/.ssh
  sudo chmod 700 /root/.ssh
  sudo echo "vagrant ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/vagrant
  sudo echo "root:vagrant" | chpasswd
  sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
  sed -i 's/#PubkeyAuthentication no/PubkeyAuthentication yes/' /etc/ssh/sshd_config
  sed -i 's/#PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
 # deb http://deb.debian.org > Update source list
  sudo apt-get install -y gnupg2
  sudo mv /etc/apt/source.list /etc/apt/source.list.bck
  # Ajout du chemin /usr/sbin dans la variables $PATH de root > .bashrc
 sudo echo export PATH=/usr/sbin:$PATH >> /root/.bashrc
  #  Installez Apache2 
  sudo apt install -y apache2
  # Installez PHP
  sudo apt-get install php-imap php-ldap php-curl php-xmlrpc php-gd php-mysql php-cas -y
  # Installer lib php
  sudo apt install -y libapache2-mod-php
  # installer mariadb
  sudo apt install mariadb-server -y
  sudo systemctl start mariadb
  sudo systemctl enable mariadb
  echo "& y y password password y y y y" | ./usr/bin/mysql_secure_installation
  # modules complémentaires
  sudo apt-get install apcupsd php-apcu -y
  # Extensions du noyau de PHP
  sudo apt-get install php-fileinfo -y
  sudo apt-get install php-filter -y
  sudo apt-get install php-libxml -y
  sudo apt-get install php-json -y
  sudo apt-get install php-dom - y 
  sudo apt-get install php-simplexml -y
  sudo apt-get install php-xmlreader -y 
  sudo apt-get install php-xmlwriter -y
  # intl extension > Requis pour l'internationalisation.
  sudo apt-get install php-intl -y
  # redemarrage du serveur apache 2 et mysql
  sudo service apache2 restart
  sudo service mariadb restart
  # Créez la base de données qui nous permettra ensuite d’installer GLPI
  sudo mysql -u root -p 
  CREATE DATABASE glpidb;
  grant all privileges on db_glpi.* to admindb_glpi@localhost identified by "P$ssword";
  EXIT;
  # Pour plus de simplicité dans l’avenir, on installera phpMyAdmin, qui va vous permettre de gérer la base de données en interface graphique :
  # sudo apt install phpmyadmin -y
  # installation de GLPI est très rapide, elle se passe en deux temps :
  # install wget
  sudo apt install wget -y
  # install GLPI
  cd /usr/src/
  sudo wget https://github.com/glpi-project/glpi/releases/download/10.0.15/glpi-10.0.15.tgz
  sudo tar -xvzf glpi-10.0.15.tgz -C /var/www/html
  sudo chown -R www-data:www-data /var/www/html 
  sudo chmod -R 755 /var/www/html
  # Set the DocumentRoot to /var/www/html/glpi/public
  # sudo sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html/glpi/public|' /etc/apache2/sites-available/000-default.conf
  # session.cookie_httponly = on
  # sudo echo 's/;session.cookie_httponly =/session.cookie_httponly = on/' /etc/php/8.2/apache2/php.ini
  echo "session.cookie_httponly = on" | sudo tee -a /etc/php/8.2/apache2/php.ini
  sudo service apache2 restart
  sudo service mariadb restart
  sudo service mysql restart
  sudo service mysql start
  SHELL
  end
  
