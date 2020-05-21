#!/bin/sh

set -e

VERSION="dev"
CODENAME="racine"

ARCHITECTURE="$(dpkg --print-architecture)"
if [ "${ARCHITECTURE}" = "arm64" ]; then
    BOOTLOADERS="grub-efi"
    MEMTEST=""
else
    BOOTLOADERS="grub-efi,syslinux"
    MEMTEST="memtest86+"
fi

if [ "$(dnsdomainname)" = "snowman.lan" ]; then
    APT_HTTP_PROXY="http://deb-proxy.snowman.lan:8000"
fi

BASE_DIR="$(dirname "$(readlink -f "$0")")"
LB_DIR="${BASE_DIR}/nobackup/lb"

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

for i in "${BASE_DIR}"/*.hook.chroot.in; do
    sed -e "s|@CODENAME@|${CODENAME}|g" \
    sed -e "s|@VERSION@|${VERSION}|g" \
    "${i}" > "${LB_DIR}/config/hooks/normal/$(basename "$i" .in)"
done

mkdir -p "${LB_DIR}/config/bootloaders/syslinux_common"
cp -a "${BASE_DIR}/splash.svg" "${LB_DIR}/config/bootloaders/syslinux_common/"

cp "${BASE_DIR}/finnix.list.chroot" "${LB_DIR}/config/package-lists/"
cp "${BASE_DIR}/finnix-${ARCHITECTURE}.list.chroot" "${LB_DIR}/config/package-lists/"

lb build
