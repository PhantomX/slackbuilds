
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-5.1-no_msits.patch
# add missed source files to src/CMakeLists.txt
# applied in upstream svn363
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-5.2-missed-src.patch

set +e +o pipefail
