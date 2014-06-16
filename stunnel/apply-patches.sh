
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-5-authpriv.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-5-sample.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-systemd-service.patch

set +e +o pipefail
