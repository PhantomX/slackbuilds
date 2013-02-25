
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.0.12-name-ext.patch
# https://bugs.launchpad.net/ubuntu/+source/dosfstools/+bug/746262
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.0.13-reserved-sectors-hack.patch

set +e +o pipefail
