
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
#patch -p1 -E --backup -z .cloexec --verbose -i ${SB_PATCHDIR}/${NAME}-1.4.10-cloexec.patch

set +e +o pipefail
