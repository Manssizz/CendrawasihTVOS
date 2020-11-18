#!/system/bin/sh
# Enable install FDisk
settings put secure install_non_market_apps 1
TOAST="am broadcast -a id.klampok.broadcast.CUSTOM_BROADCAST -e MSG "

# Install custom APK
find /system/app_install/ -name "*\.apk" -exec sh -c '$1 "Installing $(basename $0 .apk)"; pm install $0' {} "$TOAST" \;


# Data configuration
cp -pr /system/data_default/* /data/

# Enable Writable System Dir
mount -o remount,rw /system

# Moving Data
unzip -o /data/data.zip -d /data/data/ &> /dev/null
mv /data/wpa_supplicant.conf /data/misc/wifi/ &> /dev/null

rm /data/data.zip
#rm /data/wpa_supplicant.conf

rm -rf /system/data_default
rm -rf /system/app_install
#rm /data/data1.zip

$TOAST "Installing done, refreshing.."
$TOAST "Cendrawasih TV"
$TOAST "Copyright by Manssizz"
$TOAST "Rebooting Device... Please Wait..."

# Give some delay for launcer to receive broadcast
sleep 1

# Kill app to force reload modified data/config
for f in /system/data_default/data/*/; do
	killall $(basename $f)
done

reboot
