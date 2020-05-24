#!/bin/sh

set -e

VERSION="dev"
CODENAME="racine"

DATE="$(date -u +"%F %T")"
YEAR="$(date -u +"%Y")"
ARCHITECTURE="$(dpkg --print-architecture)"
if [ "${ARCHITECTURE}" = "arm64" ]; then
    BOOTLOADERS="grub-efi"
    MEMTEST=""
else
    BOOTLOADERS="grub-efi,grub-pc"
    MEMTEST="memtest86+"
fi

if [ "$(dnsdomainname)" = "snowman.lan" ]; then
    APT_HTTP_PROXY="http://deb-proxy.snowman.lan:8000"
fi

BASE_DIR="$(dirname "$(readlink -f "$0")")"
LB_DIR="${BASE_DIR}/nobackup/lb"
LB_CACHE_DIR="${BASE_DIR}/nobackup/cache/lb"

cd /
rm -rf "${LB_DIR}"
mkdir -p "${LB_DIR}"
cd "${LB_DIR}"

lb config noauto \
  --apt-http-proxy "${APT_HTTP_PROXY}" \
  --apt-recommends false \
  --architectures "${ARCHITECTURE}" \
  --archive-areas "main contrib non-free" \
  --backports false \
  --binary-images iso-hybrid \
  --bootappend-live "boot=live quiet systemd.show_status=yes" \
  --bootloaders "${BOOTLOADERS}" \
  --distribution testing \
  --hdd-label FINNIX \
  --image-name finnix \
  --iso-application Finnix \
  --iso-preparer Finnix \
  --iso-publisher Finnix \
  --iso-volume "Finnix ${VERSION}" \
  --memtest "${MEMTEST}" \
  --security false \
  --updates false \
  --mode debian

if [ -d "${LB_CACHE_DIR}" ]; then
    if [ -e "${LB_CACHE_DIR}/bootstrap/etc/hostname" ]; then
        if [ -n "$(find "${LB_CACHE_DIR}/bootstrap/etc/hostname" -mmin +1080)" ]; then
            rm -rf "${LB_CACHE_DIR}/bootstrap"
        fi
    else
        rm -rf "${LB_CACHE_DIR}/bootstrap"
    fi
    rm -rf "${LB_DIR}/cache"
    ln -sf "${LB_CACHE_DIR}" "${LB_DIR}/cache"
fi

for i in "${BASE_DIR}"/*.hook.chroot.in; do
    sed -e "s|@CODENAME@|${CODENAME}|g" \
        -e "s|@VERSION@|${VERSION}|g" \
    "${i}" > "${LB_DIR}/config/hooks/normal/$(basename "$i" .in)"
done

mkdir -p "${LB_DIR}/config/bootloaders/grub-pc"
cp "${BASE_DIR}/grub/memtest.cfg" "${LB_DIR}/config/bootloaders/grub-pc/"
sed -e "s|@CODENAME@|${CODENAME}|g" \
    -e "s|@VERSION@|${VERSION}|g" \
    -e "s|@DATE@|${DATE}|g" \
    -e "s|@YEAR@|${YEAR}|g" \
    -e "s|@ARCHITECTURE@|${ARCHITECTURE}|g" \
"${BASE_DIR}/grub/splash.svg" | rsvg-convert --format png --width 640 --height 480 >"${LB_DIR}/config/bootloaders/grub-pc/splash.png"
mkdir -p "${LB_DIR}/config/bootloaders/grub-pc/live-theme"
cp "${BASE_DIR}/grub/theme.txt" "${LB_DIR}/config/bootloaders/grub-pc/live-theme/"

cp "${BASE_DIR}/finnix.list.chroot" "${LB_DIR}/config/package-lists/"
cp "${BASE_DIR}/finnix-${ARCHITECTURE}.list.chroot" "${LB_DIR}/config/package-lists/"

lb build

ls -lsa "${LB_DIR}/finnix-${ARCHITECTURE}.hybrid.iso"
file "${LB_DIR}/finnix-${ARCHITECTURE}.hybrid.iso"
