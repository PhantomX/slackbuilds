
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

#patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/hunspell.rhbz759647.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/hunspell.rhbz918938.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/hunspell.rhbz985052.patch

set +e +o pipefail
