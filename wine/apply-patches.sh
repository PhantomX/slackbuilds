
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/wine-1.1.15-winegcc.patch.gz | patch -p1 -E --backup --verbose

# bugfixes
# http://bugs.winehq.org/show_bug.cgi?id=7698
# http://bugs2.winehq.org/attachment.cgi?id=6853
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/wine-csd.patch

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/wine-udisks1.patch

set +e +o pipefail
