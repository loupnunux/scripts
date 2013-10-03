#!/bin/bash

######################
###            SOURCES
source ./lib_arch
source ./2-antergos-params




######################
###          FONCTIONS
f_install() {
  f_pkg

  if [ ! -e /usr/bin/yaourt ]; then
    sudo pacman -S --noconfirm --force $PKG_PACMAN_YAOURT
  fi

  arch_testpck "$PKG_PACMAN"
  arch_testpck "$PKG_YAOURT"

  f_virtualbox
  f_cronie
  f_teamview
}



f_pkg() {
  PKG_PACMAN="$PKG_PACMAN_BASE $PKG_PACMAN_DESKTOP $PKG_PACMAN_EDUC $PKG_PACMAN_GNOME $PKG_PACMAN_GRAPHIC $PKG_PACMAN_INTERNET $PKG_PACMAN_JEUX $PKG_PACMAN_MEDIA $PKG_PACMAN_MTP $PKG_PACMAN_NVIDIA $PKG_PACMAN_PRINT $PKG_PACMAN_PORTABLE $PKG_PACMAN_XFCE $PKG_PACMAN_VIRTUAL $PKG_PACMAN_WINE"

  PKG_YAOURT="$PKG_YAOURT_BASE $PKG_YAOURT_DESKTOP $PKG_YAOURT_EDUC $PKG_YAOURT_GRAPHIC $PKG_YAOURT_INTERNET $PKG_YAOURT_JEUX $PKG_YAOURT_MEDIA $PKG_YAOURT_MTP $PKG_YAOURT_XFCE $PKG_YAOURT_VIRTUAL"
}



f_virtualbox() {
  if [ -e /usr/bin/virtualbox ]; then
    arch_modules "virtualbox" "vboxdrv"
    arch_modules "virtualbox" "vboxnetadp"
    arch_modules "virtualbox" "vboxnetflt"
    arch_service "dkms.service"
  fi
}



f_cronie() {
  arch_service cronie
}



f_teamview() {
  if [ -e /usr/bin/teamviewer ]; then
    arch_service "teamviewerd.service"
  fi
}












######################
###             SCRIPT
f_install

exit 1

