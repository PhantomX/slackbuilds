
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# merged upstream, build config fix
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libmcs-0.7.1-sysconfdir.patch
# merged upstream, floating point exception fix
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libmcs-0.7.1-walk.patch
# merged upstream, safety fixes in string utility functions
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libmcs-0.7.1-util.patch
# merged upstream, safety fix for keyfile set_string function
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libmcs-0.7.1-keyfile-change-string.patch

set +e +o pipefail
