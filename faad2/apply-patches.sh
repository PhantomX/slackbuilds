
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/faad2-2.6.1-implicitdeclar.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/faad2-2.7-libmp4ff-shared-lib.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/faad2-2.7-man1_MANS.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
