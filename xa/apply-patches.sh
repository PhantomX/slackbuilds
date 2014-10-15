
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# update the build system, reported in private email
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xa-2.3.5-make.patch

set +e +o pipefail
