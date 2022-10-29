# Finnix live-build tools

`finnix-live-build` is Finnix's image build system, and is a wrapper around
Debian Live's `live-build` system.

## Building

Requirements:

  - Debian testing/sid, or Ubuntu 20.04 focal or later.
  - live-build, built from [live-build git
    HEAD](https://github.com/finnix/live-build).
      - This is available as a git submodule in this repository.
      - While upstream HEAD is usually fine, the link above (and this
        repository's submodule) points to a Finnix-specific branch which is
        usually in sync with [live-build
        upstream](https://salsa.debian.org/live-team/live-build), but sometimes
        includes fixes/changes which have not (yet) been accepted upstream.
  - See `build-dependencies.json` for required host packages.

This can be built on dedicated hardware, in a virtual machine, or in a
systemd-nspawn container. Building in a chroot within one of these environments
is supported. Docker and LXD containers are not supported, as they do not allow
mounting proc/devpts (even the container-specific restricted versions), required
by live-build/debootstrap.

The default build directory will be `build/lb/` from the script directory.

## Scheduled builds

  - Weekly AMD64 builds are made on the [GitHub finnix-live-build "schedule"
    workflow](https://github.com/finnix/finnix-live-build/actions?query=workflow%3Aschedule),
    with ISO build artifacts uploaded. The "ci" workflow is built on each push
    as an indication, but artifacts are not available.
  - Daily AMD64 builds are made on a [container in a colocated
    environment](https://ci.colobox.com/colobox/finnix-live-build-amd64/), with
    ISO build artifacts uploaded to
    [snapshots.finnix.org](https://snapshots.finnix.org/ci/finnix-live-build-amd64/).
  - Indicator builds are built on [my home CI
    system](https://ci.colobox.com/home/) for many architectures (see below).
    Artifacts are not publicly available. Most architectures are built daily,
    except for slow pure emulation architectures like s390x and ppc64el.

## Architectures

finnix-live-build supports multiple architectures, but are considered in
multiple tiers:

### Tier 1

  - amd64

The only supported architecture in the sense that ISOs are officially released.
Built images are tested often. Build failures are a blocker and fixed ASAP.

### Tier 2

  - arm64
  - i386

While ISOs are not officially released, these are still considered important
architectures. Built images are tested often. Build failures are a blocker and
fixed soon.

### Tier 3

  - armhf
  - ppc64el
  - riscv64
  - s390x

Not supported, and produced images are not directly bootable. However, they can
be booted by direct kernel/initrd boot in QEMU, and are tested occasionally.
Build failures are not a blocker.

## Issues and pull requests

To open a Finnix issue, please use the main [Finnix issue
tracker](https://github.com/finnix/finnix/issues), not this repository's. Pull
requests will be considered here, but you probably also want to open an issue to
track it.

## Remastering / forking

If you are looking to build a live environment which is outside of the scope of
Finnix's goals, feel free to use this build repository as a base. In essence,
this repository is a thin wrapper around live-build, and builds upon the massive
work done by the Debian Live project. I encourage you to study this repository
and live-build, and to experiment with your own builds.

If you do produce builds based directly off the finnix-live-build repository,
please change the branding to indicate it is not an official Finnix release.
Please see the top of `finnix-live-build` for branding-related variables.

## License

finnix-live-build

Copyright (C) 2020-2022 [Ryan Finnie](https://www.finnie.org/)

This Source Code Form is subject to the terms of the Mozilla Public License, v.
2.0. If a copy of the MPL was not distributed with this file, You can obtain one
at http://mozilla.org/MPL/2.0/.
