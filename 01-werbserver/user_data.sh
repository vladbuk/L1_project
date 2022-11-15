#!/bin/bash
sudo apt update
sudo apt install -y apache2 mc
myip=$(curl ifconfig.io)
echo "<h1>My webserver running on IP: $myip</h1><p>builded by Terraform</p>" | sudo tee /var/www/html/index.html
sudo systemctl enable apache2.service
sudo systemctl start apache2.service