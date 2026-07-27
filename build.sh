#!/usr/bin/env bash
set -eo pipefail

# build-conda rather than builddir so the tree matches the existing `build-*/`
# .gitignore rule — otherwise a local `pixi build` leaves an untracked dir that
# `source: use_gitignore` would then copy into the next build.
meson setup build-conda \
    --prefix="$PREFIX" \
    --libdir=lib \
    --buildtype=release \
    -Dintrospection=disabled \
    -Dviewer=disabled \
    -Dgst-plugin=enabled \
    -Ddocumentation=disabled \
    -Dtests=false \
    -Dusb=enabled \
    -Dpacket-socket=disabled
meson compile -C build-conda
meson install -C build-conda
