# SPDX-PackageSummary: finnix-live-build
# SPDX-FileCopyrightText: © 2024 Ryan Finnie <ryan@finnie.org>
# SPDX-License-Identifier: MPL-2.0

FROM debian:testing
COPY . /build
RUN /build/container-build && rm -rf /build

FROM scratch
COPY --from=0 / /
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/games:/usr/games
# Unless overridden at runtime, this should be automatically changed to the user's home directory
WORKDIR /tmp/_defaultcwd
ENTRYPOINT ["container-entrypoint"]
CMD ["bash"]
