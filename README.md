scripts
=======


Utilisation
===========

sudo mkdir -p /home/.loupnunux

sudo chmod -R 777 /home/.loupnunux

cd /home/.loupnunux

git clone https://github.com/loupnunux/scripts.git

nano /etc/cron.d/0hourly

  # cron loupnunux

  0 * * * * root /home/.loupnunux/scripts/depot_cron
