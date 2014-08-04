
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/faad2-2.7-libmp4ff-shared-lib.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/faad2-2.7-libmp4ff-install-mp4ff_int_types_h.patch
zcat ${SB_PATCHDIR}/faad2-2.7-man1_MANS.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
