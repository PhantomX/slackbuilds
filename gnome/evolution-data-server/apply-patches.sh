
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# RH bug #243296
zcat ${SB_PATCHDIR}/${NAME}-1.11.5-fix-64bit-acinclude.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.32.1-libgdata07.patch
# Fix build with gtk+ 2.24.0
patch -p0 -E --backup -z .workaround --verbose -i ${SB_PATCHDIR}/${NAME}-2.32.2-workaround-gtkcombobox.patch

set +e +o pipefail
