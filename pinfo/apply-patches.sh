
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pinfo-0.6.9-xdg.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pinfo-0.6.9-infosuff.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pinfo-0.6.9-nogroup.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pinfo-0.6.9-mansection.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pinfo-0.6.9-infopath.patch

### Gentoo
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pinfo-0.6.9-as-needed.patch


set +e +o pipefail
