
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# add -Wl,--as-needed
# this touches both Makefile.in and Makefile.am as autoreconf is used
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/geeqie-1.0-LDFLAGS.patch

set +e +o pipefail
