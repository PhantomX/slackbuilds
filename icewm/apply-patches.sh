
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-menu.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-toolbar.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-keys.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-defaults.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.3.7-menuiconsize.patch

set +e +o pipefail
