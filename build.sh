#!/bin/sh

set -e

# This is currently quite specific to my build environment.
# FYI, "nobackup" is so my backup program will automatically skip over it.

VERSION="dev"

BASE_DIR="$(dirname "$(readlink -f "$0")")"
LB_DIR="${BASE_DIR}/nobackup/lb"

cd /
rm -rf "${LB_DIR}"
mkdir -p "${LB_DIR}"
cd "${LB_DIR}"

lb config noauto \
  --apt-http-proxy http://deb-proxy.snowman.lan:8000 \
  --apt-recommends false \
  --architectures amd64 \
  --archive-areas "main contrib non-free" \
  --backports false \
  --binary-images iso-hybrid \
  --bootappend-live "boot=live quiet systemd.show_status=yes" \
  --distribution testing \
  --hdd-label FINNIX \
  --image-name finnix \
  --iso-application Finnix \
  --iso-preparer Finnix \
  --iso-publisher Finnix \
  --iso-volume "Finnix ${VERSION}" \
  --memtest memtest86+ \
  --security false \
  --updates false \
  --mode debian

for i in "${BASE_DIR}"/*.hook.chroot.in; do
    sed -e "s|@VERSION@|${VERSION}|g" \
    "${i}" > "${LB_DIR}/config/hooks/normal/$(basename "$i" .in)"
done

mkdir -p "${LB_DIR}/config/bootloaders/syslinux_common"
cp -a "${BASE_DIR}/splash.svg" "${LB_DIR}/config/bootloaders/syslinux_common/"

cp "${BASE_DIR}/finnix.list.chroot" "${LB_DIR}/config/package-lists/"

lb build
