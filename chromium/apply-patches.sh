
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/chromium-drop_sse2-r0.patch
zcat ${SB_PATCHDIR}/${NAME}-branding_mime.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-5.0.322.2-libpng-1.4.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
