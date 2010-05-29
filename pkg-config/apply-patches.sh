
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# don't call out to glib-config, since our glib-config is a pkg-config wrapper
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.21-compat-loop.patch
# https://bugs.freedesktop.org/show_bug.cgi?id=16095
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-lib64-excludes.patch
# revert a last-minute upstream change that is causing many problems
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/escape-whitespace-revert.patch
# fix a compat problem with modern popt
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/popt-compat.patch

set +e +o pipefail
