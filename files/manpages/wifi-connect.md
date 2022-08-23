# NAME

wifi-connect - Simple Wi-Fi connection utility

# SYNOPSIS

wifi-connect \[-i *interface*\] "Access Point Name" "Access Point Passphrase"

# DESCRIPTION

`wifi-connect` is a simple command line utility to connect to a Wi-Fi access
point. It will automatically configure and activate `wpa_supplicant` using
default (WPA2) settings, and `systemd-networkd` for a basic DHCP configuration.

Note that this utility is meant to be for the most common Wi-Fi setups
encountered, and is not meant to be exhaustive.

# OPTIONS

\-i *interface*

> Interface name to configure. If not specified, the interface name will be
> selected automatically, if the system has one wireless interface. If more than
> one wireless interface is present, `wifi-connect` will list all discovered
> wireless interfaces, and *-i* will need to be explicitly set.

# BUGS

None known, many assumed.
