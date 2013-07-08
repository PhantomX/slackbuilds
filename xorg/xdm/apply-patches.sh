
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## Slackware
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xdm.glibc.crypt.diff

set +e +o pipefail
