scripts
=======


Utilisation
===========

sudo mkdir -p /home/.loupnunux

sudo chmod -R 777 /home/.loupnunux

cd /home/.loupnunux

git clone https://github.com/loupnunux/scripts.git

nano /etc/cron.d/Ohourly
  # cron loupnunux
  0 * * * * root /home/.loupnunux/scrypts/depot_cron
