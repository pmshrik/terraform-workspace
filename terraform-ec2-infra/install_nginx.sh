#!/bin/bash

sudo apt update -y
sudo apt install -y nginx 
sudo systemctl start nginx
sudo systemctl enable nginx
echo "<h1> Welcome to nginx - this is by SPM </h1>" | sudo tee /var/www/html/index.html