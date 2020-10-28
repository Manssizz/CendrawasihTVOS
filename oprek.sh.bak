#!/bin/bash
[ "$UID" = "0" ] || exec sudo "$0" "$@"

SYSDIR="kitchen/system"
SYSIMG="kitchen/system.img"

sudo cp -v original/system.img $SYSIMG || exit 1
sudo chmod 777 $SYSIMG


echo "Mounting system.img to $SYSDIR"
[ -d $SYSDIR ] || mkdir $SYSDIR
sudo mount -o loop,noatime,rw,sync $SYSIMG $SYSDIR

echo "Remove 3rd Party Apps (indihome)"
sudo rm -rf $SYSDIR/preinstall

echo "Remove Unwanted Apps"
# Must be removed, or you got Iptv Err
sudo rm -f $SYSDIR/app/MainControl.apk
sudo rm -f $SYSDIR/app/sqm.apk
sudo rm -rf $SYSDIR/app/apk

sudo rm -f $SYSDIR/app/AppsMgr-release.apk
sudo rm -f $SYSDIR/app/ajvm.apk
sudo rm -f $SYSDIR/app/AptoideTV-3.3.1-useeapps.apk
sudo rm -f $SYSDIR/app/FactoryTestTool.apk
sudo rm -f $SYSDIR/app/iptvclient_boot-release.apk
sudo rm -f $SYSDIR/app/popup-release-signed.apk
sudo rm -f $SYSDIR/app/ZTEUpgrade.apk
sudo rm -f $SYSDIR/app/ZTEBrowser.apk
sudo rm -f $SYSDIR/app/ZTEPlayer.apk

sudo rm -f $SYSDIR/app/VideoTestTool.apk
sudo rm -rf $SYSDIR/app/QuickSearchBox
sudo rm -rf $SYSDIR/app/NetworkTest
sudo rm -rf $SYSDIR/app/ztehelper
sudo rm -rf $SYSDIR/app/HomeMediaCenter

sudo rm -f $SYSDIR/app/IPTV.apk
sudo rm -f $SYSDIR/app/mcspbase.apk
sudo rm -f $SYSDIR/app/NaAgent.apk
sudo rm -f $SYSDIR/app/netmanager.apk
sudo rm -f $SYSDIR/app/nmAssistant.apk

# Cleann!
sudo rm -f $SYSDIR/app/OSDService.apk
sudo rm -f $SYSDIR/app/ZeroCfgUI.apk
sudo rm -f $SYSDIR/app/Dlnagwapt.apk
sudo rm -f $SYSDIR/app/MSGAPK.apk

sudo rm -f $SYSDIR/app/dlna.apk
sudo rm -f $SYSDIR/app/MSGAPKSub.apk
sudo rm -rf $SYSDIR/app/AuthConfig
sudo rm -rf $SYSDIR/app/SubtitleService
sudo rm -rf $SYSDIR/app/FileBrowser

# MeBox launcher
sudo rm -f $SYSDIR/app/launcher_tkz4.apk

# Must removed if using GAPPS TV
sudo rm -f $SYSDIR/app/TVClient.apk
#sudo rm -rf $SYSDIR/app/ADBSetting
sudo rm -rf $SYSDIR/app/Camera2
sudo rm -rf $SYSDIR/app/Music
sudo rm -rf $SYSDIR/app/DownloadProviderUi
sudo rm -f $SYSDIR/app/com.google.android.tts-3.10.10-210310101.apk
sudo rm -rf $SYSDIR/priv-app/Contacts/
sudo rm -rf $SYSDIR/priv-app/LiveTv/

#Uncomment if you want use hardware keyboard only (no softkeyboard)
#rm -rf $SYSDIR/app/LatinIME
#rm -rf $SYSDIR/app/OpenWnn 

echo "Remove Unwanted services"
sudo rm -f $SYSDIR/bin/netaccess
sudo rm -f $SYSDIR/bin/depconfig

echo "Bootanimation"
sudo pushd kitchen/bootanimation
[ -e ../rootfs/media/bootanimation.zip ] && sudo rm ../rootfs/media/bootanimation.zip
[ -d ../rootfs/media ] || sudo mkdir ../rootfs/media
sudo zip -0 -r '../rootfs/media/bootanimation.zip' *
popd

echo "Coying default data"
[ -d kitchen/rootfs/data_default ] || sudo mkdir -p kitchen/rootfs/data_default/data
# Fix data permissions, its changed after checkout from git
sudo chmod -R og+rw kitchen/rootfs/data_default/data/*
sudo chmod -R +x kitchen/rootfs/xbin/*
sudo chmod -R +x kitchen/rootfs/bin/*

echo 'Merge rootfs/* into $SYSDIR/*'
sudo cp -pruv kitchen/rootfs/* $SYSDIR/

echo "Unmount $SYSDIR"
sudo umount $SYSDIR

if which e2fsck &> /dev/null; then
	echo "Check/repair file system.img"
	sudo e2fsck -f $SYSIMG
fi

if which resize2fs &> /dev/null; then
	# kecilkan partisi biar ga lama bgt ngeflashnya
	echo "Minimizing system.img"
	sudo resize2fs -M $SYSIMG
fi

echo "Done, press any button (on the keyboard, not power button) to close."
read -n 1
