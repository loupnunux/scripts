#!/bin/bash

source ./lib_arch




# Pour virtualbox
arch_modules "virtualbox" "vboxdrv"
arch_modules "virtualbox" "vboxnetadp"
arch_modules "virtualbox" "vboxnetflt"
arch_service "dkms.service"


# Pour ssh
arch_service sshd


# Pour cron
arch_service cronie


# Pour teamview
arch_service "teamviewerd.service"





arch_testpck "toto titi git firefox"


