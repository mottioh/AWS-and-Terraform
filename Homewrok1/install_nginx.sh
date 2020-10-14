#! /bin/bash
sudo yum -y install nginx
sudo mv /usr/share/nginx/html/index.html index2.html
echo "<h1> <strong>OpsSchool Rules</strong></h1>" | sudo tee /usr/share/nginx/html/index.html
sudo service nginx start