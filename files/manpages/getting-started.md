# WELCOME

Welcome to {{ PRODUCT }}\!

# CUSTOM COMMANDS

This is mostly a fully-featured Debian-based text utility distribution, but
there are a few custom utilities to know about:

  - 0

> Easy (and mostly keyboard-agnostic) way to change your locale and keyboard
> information.

  - wifi-connect "Access Point" "Passphrase"

> Set up a standard WPA wireless connection.

# OTHER INFORMATION

DHCP is attemped on any found wired Ethernet interface.

For a text-mode web browser, "elinks" and "w3m" are available.

By default, no attempt is made to modify the system clock. If you would like to
sync against an NTP server (local NTP server if given by the DHCP server,
otherwise Debian's pool), run:

    timedatectl set-ntp true

If you would like to update any dpkg alternatives, such as for the "editor"
command perhaps, "rover" is a friendly curses-based alternatives selection
program.

If you need to work with ZFS disks, run the following beforehand:

    service zfs-fuse start

The running ramdisk is limited to 50% of the system's RAM by default. If you
need more working disk space, run:

    mount -o remount,size=80% /run/live/overlay

{% if PRODUCT_ID == 'finnix' %}# DOCUMENTATION

More Finnix documentation is available at [the finnix-docs repository on
GitHub](https://github.com/finnix/finnix-docs).{% endif %}
