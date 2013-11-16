#!/bin/bash
#


######################
###          VARIABLES
OPTIONS=$*
NB_OPTIONS=$#
REP_SCR=$(dirname $0)
FILE_SCR=$(basename $0)
APPS="unison"
RUN_SYNC="/usr/bin/unison"


######################
###            SOURCES
source $REP_SCR/librairie.lib





######################
###          FONCTIONS
f_actions() {
  term "Nombre d'arguments (doit etre a 1) : $NB_OPTIONS" '[ $NB_OPTIONS == 1 ]'
  term "Test du fichier de conf" '[ -e "/home/$USER/.unison/$OPTIONS" ]'
  term "Test process pour $APPS" '[ -z $(pgrep -u $USER $APPS) ]'

  warn "Tache de synchronisation" "$RUN_SYNC $OPTIONS"
}





######################
###             SCRIPT
f_actions

exit 1

