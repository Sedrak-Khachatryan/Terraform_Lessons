#!/bin/bash
yum -y update
yum -y install httpd
myip=`curl http://169.254.169.254/latest/meta-data/local-ip4`
echo "<h2>WebServer with IP: smyip</h2><br>Build by Terraform using External Script" > /var/www/html/index.html
echo <br><font color="blue">"Hello World!!!" >> /var/www/html/index.html
chkconfig httpd on
