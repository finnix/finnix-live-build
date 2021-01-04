# Finnix live-build tools

Warning: While it should be possible to build this from anywhere, it's geared mainly to myself.
If you want to build your own similar release, it's recommended to use this as a base for your own live-build project.

Requirements:

* Ubuntu 18.04 bionic or later (however, see the note about `live-build`), or Debian testing/sid.
* live-build, built from [live-build git HEAD](https://salsa.debian.org/rfinnie/live-build).
    * This is available as a git submodule in this repository.
    * If building on Ubuntu bionic, you will need to install "debhelper/bionic-backports" to pull int a newer debhelper.
    * If building on Ubuntu bionic/focal, you will need to remove `/usr/bin/checkbashisms` to work around a false positive which wasn't fixed until recently.
* Additional required packages: python3-jinja2 librsvg2-bin fonts-liberation2

This can be built on dedicated hardware, in a virtual machine, or in a systemd-nspawn container.  Building in a chroot within one of these environments is supported.  Docker and LXD containers are not supported, as they do not allow mounting proc/devpts (even the container-specific restricted versions), required by live-build/debootstrap.

The default build directory will be ```build/lb/``` from the script directory.

## Builds

* Weekly AMD64 builds are made on the [GitHub finnix-live-build "schedule" workflow](https://github.com/finnix/finnix-live-build/actions?query=workflow%3Aschedule), with ISO build artifacts uploaded.  The "ci" workflow is built on each push as an indication, but artifacts are not available.
* Daily AMD64 builds are made on a [container in a colocated environment](https://ci.colobox.com/colobox/finnix-live-build-amd64/), with ISO build artifacts uploaded to [snapshots.finnix.org](https://snapshots.finnix.org/ci/finnix-live-build-amd64/).
* Indicator builds are built on [my home CI system](https://ci.colobox.com/home/) for many architectures (see below).  Artifacts are not publicly available.  Most architectures are built daily, except for slow pure emulation architectures like s390x and ppc64el.


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

## Issues and pull requests

To open a Finnix issue, please use the main [Finnix issue tracker](https://github.com/finnix/finnix/issues), not this repository's.
Pull requests will be considered here, but you probably also want to open an issue to track it.
