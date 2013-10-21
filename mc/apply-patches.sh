
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mc-cpiosegfault.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mc-widgetsegfault.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mc-VFSsegfault.patch

### Slackware
# Upstream bugfix for crash moving directories:
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/changeset_54a5139eec69438f8771ffddcff96a2e72a197ff.diff
# Upstream fix for cmdline directory handling:
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/changeset_446748619b5cb77ea63360a81bb16cd2dd2caff7.diff

set +e +o pipefail
