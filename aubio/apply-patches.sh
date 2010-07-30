
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Fedora
# Fix byte-compilation error. Borrowed from Debian
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/aubio-numarray-gnuplot.patch
# Fix DSO-linking failure
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/aubio-linking.patch

set +e +o pipefail
