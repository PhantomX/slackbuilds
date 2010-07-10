
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# don't call out to glib-config, since our glib-config is a pkg-config wrapper
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.21-compat-loop.patch
# https://bugs.freedesktop.org/show_bug.cgi?id=16095
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-lib64-excludes.patch
# https://bugzilla.redhat.com/show_bug.cgi?id=611781
patch -p1 -R -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-dnl.patch

set +e +o pipefail
