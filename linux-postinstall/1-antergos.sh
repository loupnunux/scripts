#!/bin/bash

source ./lib_arch




# Pour virtualbox
arch_modules "virtualbox" "vboxdrv"
arch_modules "virtualbox" "vboxnetadp"
arch_modules "virtualbox" "vboxnetflt"
arch_service "dkms.service"


# Pour cron
arch_service cronie


# Pour teamview
arch_service "teamviewerd.service"




