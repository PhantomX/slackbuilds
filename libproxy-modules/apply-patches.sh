
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libproxy-0.4.10-mozjs.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-pacrunner_mozjs-Also-support-mozjs-17.0.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Add-config-module-for-querying-PacRunner-d-mon.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/libproxy-r871.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/libproxy-r872.patch

set +e +o pipefail
