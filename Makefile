# SPDX-PackageSummary: finnix-live-build
# SPDX-FileCopyrightText: © 2021 Ryan Finnie <ryan@finnie.org>
# SPDX-License-Identifier: MPL-2.0

.PHONY: all test lint

all:

test: lint

lint:
	env LINT=true ./finnix-live-build
