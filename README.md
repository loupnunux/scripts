scripts
=======


Utilisation
===========

sudo mkdir -p /home/.loupnunux

cd /home/.loupnunux

git clone https://github.com/loupnunux/scripts.git

nano /etc/cron.d/Ohourly
  # cron loupnunux
  * */1 * * * root /home/.loupnunux/scrypts/depot_cron
