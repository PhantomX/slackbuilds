
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-shared-nvctrl.patch
patch -p0 -E --backup -z .jansson --verbose -i ${SB_PATCHDIR}/${NAME}-system-jansson.patch
zcat ${SB_PATCHDIR}/${NAME}-190.36-vmproto.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
