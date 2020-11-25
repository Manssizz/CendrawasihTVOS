#!/bin/bash
UPDATEBIN="./tools/linux/update"
$UPDATEBIN scan | grep 'No ' && exit 1

echo "FLASHING"
#[ -e release/u-boot.bin ] && $UPDATEBIN partition bootloader release/u-boot.bin
[ -e release/boot.img ] && $UPDATEBIN partition boot release/boot.img
[ -e release/conf.img ] && $UPDATEBIN partition conf release/conf.img
#[ -e release/logo.img ] && $UPDATEBIN partition logo kitchen/logo.img
[ -e release/env.img ] && $UPDATEBIN partition env release/env.img
[ -e release/recovery.img ] && $UPDATEBIN partition recovery release/recovery.img
$UPDATEBIN partition system mod/system.img
$UPDATEBIN bulkcmd "amlmmc erase data"
$UPDATEBIN bulkcmd "amlmmc erase cache"
$UPDATEBIN bulkcmd "setenv hdmimode 720p60hz"
$UPDATEBIN bulkcmd "setenv -f EnableSelinux permissive"
$UPDATEBIN bulkcmd "setenv firstboot 1"
$UPDATEBIN bulkcmd "saveenv"
echo "DONE"
#read -n 1
