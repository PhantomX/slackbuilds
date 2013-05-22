
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-1.2.0-aclocal.diff.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fix_ftbfs_gtk_2_20.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fix_ftbfs_gtk_2_36.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fix_ftbfs_gtk_2_37.patch

set +e +o pipefail
