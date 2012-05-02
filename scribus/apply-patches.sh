
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# fix version variable for buildsystem
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.3.7-version.patch
# use versioned documentation directory
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.4.0-docdir.patch

set +e +o pipefail
