
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.6.4-hilight.patch
zcat ${SB_PATCHDIR}/${NAME}-1.6.1-locale.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-wrap_header.patch
zcat ${SB_PATCHDIR}/${NAME}-1.6.4-rh457719.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-1.6.4-rh457720.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-rh477382.patch

set +e +o pipefail
