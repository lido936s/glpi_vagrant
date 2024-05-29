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
sudo apt install -y mariadb-server -y
sudo systemctl start mariadb
sudo systemctl enable mariadb
sudo mysql_secure_installation <<EOF
y
y
y
y
y
ludovic.frere75@gmail.com
EOF
# modules complémentaires
sudo apt-get install apcupsd php-apcu
# redemarrage du serveur apache 2 et mysql
sudo service apache2 restart
sudo service mariadb restart
# Créez la base de données qui nous permettra ensuite d’installer GLPI
sudo mysql -u root -p <<EOF
CREATE DATABASE glpidb;
CREATE USER 'glpi'@'localhost' IDENTIFIED BY 'glpi';
GRANT ALL PRIVILEGES ON glpi.* TO 'glpi'@'localhost';
FLUSH PRIVILEGES;
EOF
# Pour plus de simplicité dans l’avenir, on installera phpMyAdmin, qui va vous permettre de gérer la base de données en interface graphique :
sudo apt install phpmyadmin -y
# installation de GLPI est très rapide, elle se passe en deux temps :
cd /usr/src/
wget https://github.com/glpi-project/glpi/releases/download/10.0.15/glpi-10.0.15.tgz
tar -xvzf glpi-10.0.15.tgz -C /var/www/html
sudo chown -R www-data:www-data /var/www/html 
sudo chmod -R 755 /var/www/html
# other configurations
SHELL
end
