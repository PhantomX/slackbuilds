
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Fix compilation in a gnome environment
zcat ${SB_PATCHDIR}/dia-0.97.0-gnome-doc.patch.gz | patch -p1 -E --backup --verbose
# Fix compilation python
zcat ${SB_PATCHDIR}/dia-0.97-acinclude-python-fixes.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dia-0.97.1-libpng15.patch

set +e +o pipefail
