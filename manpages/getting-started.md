% GETTING-STARTED(1) | {{ PRODUCT }}
# WELCOME

Welcome to {{ PRODUCT }}!

# CUSTOM COMMANDS

This is mostly a fully-featured Debian-based text utility distribution, but there are a few custom utilities to know about:

0
:   Easy (and mostly keyboard-agnostic) way to change your locale and keyboard information.

wifi-connect "Access Point" "Passphrase"
:   Set up a standard WPA wireless connection.

# OTHER INFORMATION

DHCP is attemped on any found wired Ethernet interface. For a text-mode web browser, "elinks" and "w3m" are available.

If you would like to update any dpkg alternatives, such as for the "editor" command perhaps, "rover" is a friendly curses-based alternatives selection program.

If you need to work with ZFS disks, run the following beforehand:

    service zfs-fuse start
