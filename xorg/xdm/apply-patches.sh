
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## Slackware
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xdm.glibc.crypt.diff

### Fedora
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/xdm-1.0.5-sessreg-utmp-fix-bug177890.patch

set +e +o pipefail
