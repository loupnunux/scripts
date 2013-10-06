#!/bin/bash
#


######################
###          VARIABLES
OPTIONS=$*
REP_SCR=$(dirname $0)
FILE_SCR=$(basename $0)
FILE_PASSWD="/etc/passwd"
FILE_GROUP="/etc/group"





######################
###            SOURCES
source $REP_SCR/librairie.lib





######################
###          FONCTIONS
f_prerequis() {
  menu "list" "Changer quoi ?" "UID GID"
  Q1=$MENU_RESULT

  if [ "$Q1" == "UID" ]; then
    menu "list" "Quel UID est a changer ?" "$(cat $FILE_PASSWD | grep :10[0-9][0-9] | cut -d":" -f1,3)"
    UID_OLD=$(echo $MENU_RESULT | cut -d":" -f2)
    USER_CHANGE=$(echo $MENU_RESULT | cut -d":" -f1)
  elif [ "$Q1" == "GID" ]; then
    menu "list" "Quel GID est a changer ?" "$(cat $FILE_GROUP | grep :10[0-9][0-9] | cut -d":" -f1,3)"
    GID_OLD=$(echo $MENU_RESULT | cut -d":" -f2)
    USER_CHANGE=$(echo $MENU_RESULT | cut -d":" -f1)
  fi

  term "Test session ouverte $USER_CHANGE" '[ -z "$(ps -edf | cut -d" " -f1 | grep $USER_CHANGE)" ]'

  f_uidgid

  menu "no" "Appliquer les changement ?"
  if [ "$MENU_RESULT" == "yes" ]; then
    f_action
  fi
}



f_uidgid() {
  menu "quest" "Quel sera le nouveau $Q1 (>1000) ?"
  R1=$MENU_RESULT
  term "Test si $Q1 >= 1000" "[ $R1 -ge 1000 ]"
  f_test_uidgid

  if [ "$(cat $FILE_GROUP | grep $UID_OLD | cut -d":" -f1)" == "$USER_CHANGE" ] && [ -z "$GID_NEW" ]; then
    menu "yes" "Le user $USER_CHANGE a aussi un GID=$UID_OLD\nle changer egalement ?"
    if [ "$MENU_RESULT" == "yes" ]; then
      Q1="GID"
      GID_OLD=$UID_OLD
      R1=$UID_NEW
      f_test_uidgid
    fi
  elif [ "$(cat $FILE_PASSWD | grep $GID_OLD | cut -d":" -f1)" == "$USER_CHANGE" ] && [ -z "$UID_NEW" ]; then
    menu "yes" "Le user $USER_CHANGE a aussi un UID=$GID_OLD\nle changer egalement ?"
    if [ "$MENU_RESULT" == "yes" ]; then
      Q1="UID"
      UID_OLD=$GID_OLD
      R1=$GID_NEW
      f_test_uidgid
    fi
  fi
}



f_test_uidgid() {
  if [ "$Q1" == "UID" ]; then
    UID_NEW=$R1
    term "Test UID $UID_NEW libre" "[ -z "$(cat $FILE_PASSWD | grep $UID_NEW )" ]"
  elif  [ "$Q1" == "GID" ]; then
    GID_NEW=$R1
    term "Test GID $GID_NEW libre" "[ -z "$(cat $FILE_GROUP | grep $GID_NEW )" ]"
  fi
}



f_action() {
  if [ ! -z "$UID_NEW" ]; then
    simple "$USER_CHANGE : changement UID de $UID_OLD -> $UID_NEW"
#    warn "Change owner" "find / -user $UID_OLD -exec chown $UID_NEW {} \;"
#    warn "Enregistrement des parametres UID" "sed -i 's/$UID_OLD/$UID_NEW/' $FILE_PASSWD"
  fi

  if [ ! -z "$GID_NEW" ]; then
    simple "$USER_CHANGE : changement GID de $GID_OLD -> $GID_NEW"
#    warn "Change group" "find / -group $UID_OLD -exec chgrp $UID_NEW {} \;"
#    warn "Enregistrement des parametres GID" "sed -i 's/$GID_OLD/$GID_NEW/' $FILE_GROUP"
  fi
}





######################
###             SCRIPT
f_prerequis

exit 1

