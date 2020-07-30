# Finnix live-build tools

Warning: While it should be possible to build this from anywhere, it's geared mainly to myself.
If you want to build your own similar release, it's recommended to use this as a base for your own live-build project.

Requirements:

* Debian sid build environment
* live-build, built from [live-build git HEAD](https://salsa.debian.org/live-team/live-build)
* python3-jinja2, librsvg2-bin, fonts-liberation2

The default build directory will be ```nobackup/lb/``` from the script directory ("nobackup" is so my home network backup program will skip over it).

## Architectures

finnix-live-build supports multiple architectures, but are considered in multiple tiers:

### Tier 1

* amd64

The only supported architecture in the sense that ISOs are officially released.  Built images are tested often.  Build failures are a blocker and fixed ASAP.

### Tier 2

* arm64
* i386

While ISOs are not officially released, these are still considered important architectures.  Built images are tested often.  Build failures are a blocker and fixed soon.

### Tier 3

* armhf
* ppc64el
* s390x

Not supported, and produced images are not directly bootable.  However, they can be booted by direct kernel/initrd boot in QEMU, and are tested occasionally.  Build failures are not a blocker.

### Tier 4

* armel

Not supported, build errors are not a blocker, images are not tested.  finnix-live-build may or may not succeed at producing images, let alone usable images.  Only mentioned here since mentions of this architecture are contained within finnix-live-build.

## Issues and pull requests

To open a Finnix issue, please use the main [Finnix issue tracker](https://github.com/finnix/finnix/issues), not this repository's.
Pull requests will be considered here, but you probably also want to open an issue to track it.
