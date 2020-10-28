#!/bin/bash
[ "$UID" = "0" ] || exec sudo "$0" "$@"
SYSIMG="system.img"

if which e2fsck &> /dev/null; then
	echo "Check/repair file system.img"
	e2fsck -f $SYSIMG
fi

if which resize2fs &> /dev/null; then
	# kecilkan partisi biar ga lama bgt ngeflashnya
	echo "Minimizing system.img"
	resize2fs -M $SYSIMG
fi
