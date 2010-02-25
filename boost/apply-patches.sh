#!/bin/sh

set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/boost-version-override.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/boost-gcc-soname.patch.gz |sed "s/__SONAME__/${SONAMEVER}/" | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/boost-graph-compile.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/boost-1.41.0-shared_ptr_serialization.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/boost-1.41.0-parameter-needs-python.patch.gz | patch -p0 -E --backup --verbose || exit 1

set +e +o pipefail
