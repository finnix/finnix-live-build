# SPDX-PackageSummary: finnix-live-build
# SPDX-FileCopyrightText: © 2025 Ryan Finnie <ryan@finnie.org>
# SPDX-License-Identifier: MPL-2.0

FROM docker.io/library/debian:testing AS prebuild
ARG BUILD_TAGS
ARG BUILD_URL
ARG GITHUB_SERVER_URL
ARG GITHUB_REPOSITORY
ARG GITHUB_RUN_ID
COPY . /prebuild
ENV DOCKER_BUILD=true
WORKDIR /prebuild
RUN apt update && apt -y install git python3 && ( ./tools/get-dependencies | xargs apt -y install )
RUN git submodule update --init --recursive
RUN ./finnix-live-build

FROM docker.io/library/debian:testing AS build
COPY --from=prebuild /prebuild/build/docker /build
RUN /build/container-build && rm -rf /build

FROM scratch AS assemble
COPY --from=build / /
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/games:/usr/games
# Unless overridden at runtime, this should be automatically changed to the user's home directory
WORKDIR /tmp/_defaultcwd
ENTRYPOINT ["container-entrypoint"]
CMD ["bash"]
