# glpi_vagrant
Installer GLPI avec Vagrant Cloud
Pour installer GLPI (Gestionnaire de parc informatique) avec Vagrant et Vagrant Cloud, vous pouvez suivre les étapes suivantes :

To install GLPI on a CentOS 8 machine using Vagrant Cloud, you can follow these steps:

Install Vagrant and VirtualBox on your machine if you haven't already. You can download them from the official websites:

Vagrant: https://www.vagrantup.com/downloads.html
VirtualBox: https://www.virtualbox.org/wiki/Downloads

Open a terminal or command prompt and navigate to the directory where you want to create your Vagrant environment.

Run the following command to initialize a new Vagrant project

vagrant init centos/8
Once the initialization is complete, you can add the GLPI box to your Vagrantfile. Open the Vagrantfile in a text editor and add the following lines:
# Networking configuration :
Vagrant.configure("2") do |config|
  config.vm.network "forwarded_port", guest: 80, host: 8080
end

Save the Vagrantfile and run the following command to start the Vagrant environment:

vagrant up

Vagrant will download the CentOS 8 box from Vagrant Cloud and start the virtual machine. It may take some time depending on your internet speed.
Once the virtual machine is up and running, you can SSH into it using the following command:

vagrant ssh

Inside the virtual machine, you can install GLPI by following the official installation guide for CentOS. Here are the general steps:
Update the package list: sudo yum update
Install the necessary dependencies: sudo yum install epel-release
Install GLPI: sudo yum install glpi
After the installation is complete, you can configure GLPI by editing the configuration file: /etc/httpd/conf.d/glpi.conf.
Start the GLPI service: sudo systemctl start httpd
Access GLPI by opening a web browser and navigating to http://localhost:8080.
That's it! You should now have GLPI installed and running on your CentOS 8 machine using Vagrant.

Assurez-vous d'avoir Vagrant installé sur votre système. Vous pouvez le télécharger et l'installer à partir du site officiel de Vagrant.
Créez un fichier Vagrantfile dans un répertoire de votre choix. Voici un exemple de contenu pour le fichier Vagrantfile :

Téléchargez les fichiers nécessaires pour configurer GLPI. Vous pouvez utiliser la commande wget pour télécharger les fichiers suivants :
glpi_db_schema.sql : https://github.com/glpi-project/glpi/blob/main/install/mysql/glpi-0.85.5-empty.sql
glpi_frontend.conf : unknow
Ouvrez un terminal, naviguez jusqu'au répertoire contenant le fichier Vagrantfile, puis exécutez la commande vagrant up pour démarrer la machine virtuelle.
Attendez que la machine virtuelle soit prête. Une fois que la machine est prête, vous pouvez accéder à GLPI en utilisant l'URL suivante dans votre navigateur : http://localhost:8080/glpi
Notez que cet exemple utilise une machine virtuelle CentOS 7 avec Apache et MySQL. Vous pouvez ajuster le fichier Vagrantfile en fonction de vos préférences en termes de système d'exploitation et de serveur web.

source : https://github.com/glpi-project/


