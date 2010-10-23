
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-1.0.1-f2py.patch.gz | patch -p1 -E --backup --verbose

# Fedora

set +e +o pipefail
