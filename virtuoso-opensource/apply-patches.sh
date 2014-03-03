
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-6.1.0-external_iodbc.patch
patch -p1 -E --backup -z .nodemos_buildfix --verbose -i ${SB_PATCHDIR}/${NAME}-6.1.0-nodemos_buildfix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-6.1.4-no_strip.patch

set +e +o pipefail
