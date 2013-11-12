#!/bin/bash
#


######################
###          VARIABLES
OPTIONS=$*
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
  _test_nb_args "1" "$OPTIONS"
  term "Test process pour $APPS" '[ -z $(pgrep -u $USER $APPS) ]'

  warn "Synchro en cours" "$RUN_SYNC $OPTIONS"
}





######################
###             SCRIPT
f_actions

exit 1

