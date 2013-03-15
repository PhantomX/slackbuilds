
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kross-interpreters-ruby19.patch

set +e +o pipefail
