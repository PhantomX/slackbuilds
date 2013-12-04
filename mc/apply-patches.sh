
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mc-cpiosegfault.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mc-widgetsegfault.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mc-VFSsegfault.patch

### Slackware

set +e +o pipefail
