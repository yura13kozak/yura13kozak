!/bin/bash
set -x
sudo apt update
sudo apt install apache2 -y
sudo ufw app list && sudo ufw allow 'Apache'
sudo systemctl status apache2 --no-pager
sudo systemctl restart apache2

sudo mkdir /var/www/yura_13_kozak_com
sudo chown -R $USER:$USER /var/www/yura_13_kozak_com
sudo chmod -R 777 /var/www/yura_13_kozak_com
sudo cat <<'EOT'> /var/www/yura_13_kozak_com/index.html

<html>
    <head>
        <title>Welcome to my website!</title>
    </head>
    <body>
        <h1>Yura13Kozak</h1>
    </body>
</html>
EOT

sudo cat > ./temp <<EOL

<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    ServerName yura_13_kozak_com
    ServerAlias www.yura_13_kozak_com
    DocumentRoot /var/www/yura_13_kozak_com
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOL

sudo cat temp | sudo tee /etc/apache2/sites-available/yura_13_kozak_com.conf
sudo rm -f temp

sudo a2ensite yura_13_kozak_com.conf
sudo a2dissite 000-default.conf
sudo apache2ctl configtest
sudo systemctl restart apache2

git init
git add ./
git commit -m "First commit"
git add remote origin git@github.com:yura13kozak/yura13kozak.git
git push --set-upstream origin master

firefox http://127.0.0.1/

