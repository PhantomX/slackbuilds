
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## upstream patches
# proposed by dfaure, should help fix http://bugzilla.redhat.com/858271
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/nepomuk-core-4.9.2-isEmpty_crash.patch

set +e +o pipefail
