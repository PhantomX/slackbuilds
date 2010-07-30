
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-1.0.1-f2py.patch.gz | patch -p1 -E --backup --verbose

# Fedora
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/numpy_doublefree.patch
# PyOS_ascii_strtod is deprecated in python 2.7
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/numpy-1.4.1-remove-PyOS_ascii_strtod.patch

set +e +o pipefail
