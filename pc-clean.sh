#!/bin/bash
#


######################
###          VARIABLES
OPTIONS=$*
REP_SCR=$(dirname $0)
FILE_SCR=$(basename $0)
SUP_INCLUDE=( "*.mp4.stat.mbtree" "*.mp4.stat" "*.avi.stat.mbtree" "*.avi.stat" "Thumbs.db" ".directory" "*~" )




######################
###            SOURCES
source $REP_SCR/librairie.lib





######################
###          FONCTIONS
f_clean_rep() {
  for i in $(ls -1 /home)
  do
    warn "Nettoyage de /home/$i" "f_clean /home/$i"
  done
}



f_clean() {
  for i in ${SUP_INCLUDE[*]}
  do
    find $1 -iname $i -exec rm {} \;
  done
}








######################
###             SCRIPT
mod_root
f_clean_rep

exit 1

