Vagrant.configure("2") do |config| config.vm.box = "centos/7" config.vm.provision 
    "shell", inline: <<-SHELL 
    sudo yum install -y httpd mariadb-server php php-mysqlnd php-gd 
    sudo systemctl start httpd sudo mysql -u root -p < /vagrant/glpi_db_schema.sql 
    sudo mysql -u root -p -e "GRANT ALL PRIVILEGES ON . TO glpi@localhost IDENTIFIED BY 'glpi';" 
    sudo mysql -u root -p -e "FLUSH PRIVILEGES;" 
    sudo cp /vagrant/glpi_frontend.conf /etc/httpd/conf.d/ sudo systemctl restart httpd SHELL 
end
