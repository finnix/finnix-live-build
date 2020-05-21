# Finnix live-build tools

Warning: While it should be possible to build this from anywhere, it's geared mainly to myself.
If you want to build your own similar release, it's recommended to use this as a base for your own live-build project.

Requirements (as of 2020-05-21):

* Debian sid build environment
* live-build, built from [live-build git HEAD](https://salsa.debian.org/live-team/live-build)
* If building for arm64, [this merge request](https://salsa.debian.org/live-team/live-build/-/merge_requests/202) if it hasn't been accepted yet

The default build directory will be ```nobackup/lb/``` from the script directory ("nobackup" is so my home network backup program will skip over it).
