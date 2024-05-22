# glpi_vagrant
Installer GLPI avec Vagrant Cloud

Pour installer GLPI (Gestionnaire de parc informatique) avec Vagrant et Vagrant Cloud, vous pouvez suivre les étapes suivantes :

Assurez-vous d'avoir Vagrant installé sur votre système. Vous pouvez le télécharger et l'installer à partir du site officiel de Vagrant.
Créez un fichier Vagrantfile dans un répertoire de votre choix. Voici un exemple de contenu pour le fichier Vagrantfile :

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.provision "shell", inline: <<-SHELL
    sudo yum install -y httpd mariadb-server php php-mysqlnd php-gd
    sudo systemctl start httpd
    sudo mysql -u root -p < /vagrant/glpi_db_schema.sql
    sudo mysql -u root -p -e "GRANT ALL PRIVILEGES ON *.* TO glpi@localhost IDENTIFIED BY 'glpi';"
    sudo mysql -u root -p -e "FLUSH PRIVILEGES;"
    sudo cp /vagrant/glpi_frontend.conf /etc/httpd/conf.d/
    sudo systemctl restart httpd
  SHELL
end


Téléchargez les fichiers nécessaires pour configurer GLPI. Vous pouvez utiliser la commande wget pour télécharger les fichiers suivants :
glpi_db_schema.sql : https://github.com/glpi-project/glpi/blob/main/install/mysql/glpi-0.85.5-empty.sql
glpi_frontend.conf : unknow
Ouvrez un terminal, naviguez jusqu'au répertoire contenant le fichier Vagrantfile, puis exécutez la commande vagrant up pour démarrer la machine virtuelle.
Attendez que la machine virtuelle soit prête. Une fois que la machine est prête, vous pouvez accéder à GLPI en utilisant l'URL suivante dans votre navigateur : http://localhost:8080/glpi
Notez que cet exemple utilise une machine virtuelle CentOS 7 avec Apache et MySQL. Vous pouvez ajuster le fichier Vagrantfile en fonction de vos préférences en termes de système d'exploitation et de serveur web.

source : https://github.com/glpi-project/
