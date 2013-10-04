#!/bin/bash


######################
##          VARIABLES
OPTIONS=$*
REP_SCR=$(dirname $0)
FILE_SCR=$(basename $0)
INFO=$REP_SCR/$HOSTNAME.info






######################
###            SOURCES
source $REP_SCR/lib_arch
source $REP_SCR/2-antergos-params





######################
###          FONCTIONS
f_version(){
  if [ ! -e $INFO ]; then
    touch $INFO
  else
    source $INFO
#   On determine la nouvelle version
    VMAJ=$(ls -l --full-time $REP_SCR/2-antergos-params | cut -d " " -f6)-$(ls -l --full-time $REP_SCR/2-antergos-params | cut -d " " -f7)
    if [ "$VMAJ" == "$LAST_VMAJ" ]; then
      f_action maj
    else
      f_action install
    fi
  fi
}



f_action() {
  f_pkg

# Si yaourt n' est pas installe on l install
  if [ ! -e /usr/bin/yaourt ]; then
    sudo pacman -S --noconfirm --force $PKG_PACMAN_YAOURT
  fi

  if [ "$1" == "install" ]; then
    arch_testpck "$PKG_PACMAN"
    arch_testpck "$PKG_YAOURT"
    if [ ! -z "$PKG_YES" ]; then
      sudo yaourt --sucre $PKG_YES
    fi
#  elif [ "$1" == "maj" ]; then
#    sudo yaourt --sucre
  fi

# On regle tous les modules et services
  f_virtualbox
  f_cronie
  f_ssh
  f_teamview

  f_fin
}



f_pkg() {
  PKG_PACMAN="$PKG_PACMAN_BASE $PKG_PACMAN_DESKTOP $PKG_PACMAN_EDUC $PKG_PACMAN_GNOME $PKG_PACMAN_GRAPHIC $PKG_PACMAN_INTERNET $PKG_PACMAN_MEDIA $PKG_PACMAN_MTP $PKG_PACMAN_PRINT $PKG_PACMAN_XFCE $PKG_PACMAN_WINE"
#$PKG_PACMAN_JEUX
#$PKG_PACMAN_NVIDIA
#$PKG_PACMAN_PORTABLE
#$PKG_PACMAN_VIRTUAL

  PKG_YAOURT="$PKG_YAOURT_BASE $PKG_YAOURT_DESKTOP $PKG_YAOURT_EDUC $PKG_YAOURT_GRAPHIC $PKG_YAOURT_INTERNET $PKG_YAOURT_MEDIA $PKG_YAOURT_MTP $PKG_YAOURT_XFCE"
#$PKG_YAOURT_JEUX
#$PKG_YAOURT_VIRTUAL
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



f_ssh() {
  arch_service sshd
}



f_teamview() {
  if [ -e /usr/bin/teamviewer ]; then
    arch_service "teamviewerd.service"
  fi
}



f_fin() {
  if [ -z $LAST_VMAJ ]; then
    echo "LAST_VMAJ=$VMAJ" >> $INFO
  elif [ "$LAST_VMAJ" != "$VMAJ" ]; then
#   On change la ligne
    sed -i 's/^LAST_VMAJ=.*$/LAST_VMAJ='$VMAJ'/g' $INFO
  fi
}






######################
###             SCRIPT
f_version

exit 1

