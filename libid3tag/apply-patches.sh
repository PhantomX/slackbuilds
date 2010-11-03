
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/libid3tag-0.15.1b-64bit-long.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/libid3tag-0.15.1b-a_capella.patch.gz | patch -p2 -E --backup --verbose
zcat ${SB_PATCHDIR}/libid3tag-0.15.1b-compat.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/libid3tag-0.15.1b-file-write.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/libid3tag-0.15.1b-fix_overflow.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/libid3tag-0.15.1b-tag.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/libid3tag-0.15.1b-unknown-encoding.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/libid3tag-0.15.1b-utf16.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
