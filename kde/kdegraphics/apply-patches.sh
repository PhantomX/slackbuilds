
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.gwenview.jpeg8.diff
zcat ${SB_PATCHDIR}/${NAME}-4.2.2-workaround-kolorpaintcrash.patch.gz | patch -p1 -E --backup --verbose
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.1-fix-ksnapshot-crash.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.3-sync-libkdcraw-trunk.patch 

set +e +o pipefail
