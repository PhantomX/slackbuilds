
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.6.16-makefile.patch
patch -p1 -E --backup -z .noup --verbose -i ${SB_PATCHDIR}/${NAME}-1.7.0-noupdate.patch

set +e +o pipefail
