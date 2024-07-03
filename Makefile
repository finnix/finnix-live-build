# SPDX-PackageSummary: finnix-live-build
# SPDX-FileCopyrightText: Copyright (C) 2021-2024 Ryan Finnie
# SPDX-License-Identifier: MPL-2.0

.PHONY: all test lint

all:

test: lint

lint:
	env LINT=true ./finnix-live-build
