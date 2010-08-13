
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/libX11-dont-forward-keycode-0.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
