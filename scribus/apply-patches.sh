
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# use versioned documentation directory
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.4.0-docdir.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-to-double.patch

set +e +o pipefail
