
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.5.10-nocheck.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.5.10-nostrip.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.5.12-manpage.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.5.12-ncursesw.patch

set +e +o pipefail
