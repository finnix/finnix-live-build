#!/bin/sh

set -e

# This is currently quite specific to my build environment.
# FYI, "nobackup" is so my backup program will automatically skip over it.

BASE_DIR="$(dirname "$(readlink -f "$0")")"
LB_DIR="${LB_DIR}/nobackup/lb"

cd /
rm -rf "${LB_DIR}"
mkdir -p "${LB_DIR}"
cd "${LB_DIR}"

lb config noauto \
  --apt-http-proxy http://deb-proxy.snowman.lan:8000 \
  --apt-recommends false \
  --architectures amd64 \
  --archive-areas "main contrib non-free" \
  --backports true \
  --binary-images iso-hybrid \
  --bootappend-live "boot=live quiet systemd.show_status=yes" \
  --hdd-label FINNIX \
  --iso-application Finnix \
  --iso-preparer Finnix \
  --iso-publisher Finnix \
  --iso-volume "Finnix dev" \
  --linux-packages linux-image-5.4.0-0.bpo.4 \
  --memtest memtest86+ \
  --mode debian
cp -a "${BASE_DIR}"/*.hook.chroot "${LB_DIR}/config/hooks/normal/"
mkdir -p "${LB_DIR}/config/bootloaders/isolinux"
cp -a "${BASE_DIR}/isolinux"/* "${LB_DIR}/config/bootloaders/isolinux/"

(for i in \
  2ping apt-utils arj arpwatch at attr bc bittornado bonnie++ netcat picocom \
  btrfs-progs buffer bzip2 ca-certificates cabextract cdbackup cdpr chntpw   \
  console-data cpio cron cryptsetup-bin curl debootstrap dnsutils dosfstools \
  dselect dump dvd+rw-tools ed eject etherwake ethtool fetchmail file finger \
  fsarchiver fxload gawk gddrescue gdisk genromfs gpm grepcidr hdparm        \
  hexedit hfsutils htop ifenslave iftop iotop ipcalc iptables iptraf-ng      \
  iputils-ping irssi isomd5sum jfsutils joe less lftp lm-sensors lpr lrzsz   \
  lsof ltrace lvm2 makedev man-db mbr mc mdadm memtester minicom mt-st       \
  mtools mtr-tiny nano netcat-openbsd nmap ntfs-3g ntpdate nvme-cli          \
  openssh-client openssh-server openvpn p7zip parted patch pcmciautils       \
  pppconfig pppoe pppoeconf pptp-linux procinfo pv rdate rdiff-backup        \
  reiser4progs reiserfsprogs rlwrap robotfindskitten rsync screen wakeonlan  \
  setserial sharutils sl smartmontools smbclient cifs-utils snmp             \
  squashfs-tools sshfs strace stress stunnel4 sudo tcpdump tftp time tmux    \
  tofrodos traceroute udftools units unp unzip usbutils uuid-runtime vlan    \
  wget whois wipe wireless-tools wodim wpasupplicant xfsdump xfsprogs        \
  zerofree zile zip arping bridge-utils testdisk nicstat quota quotatool     \
  kpartx kbd acpi cmospwd cpuid dmidecode gpart lilo fdutils fuseext2        \
  lsb-release psmisc powermgmt-base net-tools thin-provisioning-tools        \
  lrzip xxhash w3m git ncat telnet partclone elinks console-setup            \
  fonts-ubuntu efibootmgr efivar efitools pciutils lshw bash-completion      \
  live-tools locales user-setup keyboard-configuration bcache-tools dbus     \
  udisks2 udisks2-bcache udisks2-btrfs udisks2-lvm2 udisks2-vdo udisks2-zram \
  exfat-utils f2fs-tools libblockdev-mdraid2 exfat-fuse policykit-1          \
  zram-tools libblockdev-crypto2 xz-utils;
do echo $i; done) | sort >"${LB_DIR}/config/package-lists/finnix.list.chroot"

lb build
