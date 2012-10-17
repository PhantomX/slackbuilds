
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/arts-acinclude.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/kde-3.5.10-kde3-standarddirs.patch
zcat ${SB_PATCHDIR}/${NAME}-1.1.1-slackware.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-1.1.1-interfaces-crash.patch.gz | patch -p0 -E --backup --verbose
# Adapted from Trinity Desktop
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.1.1-gcc47.patch

set +e +o pipefail
