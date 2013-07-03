
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# https://bugs.kde.org/show_bug.cgi?id=318825
patch -p1 -E --backup --verbose -d kopete -i ${SB_PATCHDIR}/${NAME}-mediastreamer29.patch

# rhbz#540433 - KPPP is unable to add DNS entries to /etc/resolv.conf
zcat ${SB_PATCHDIR}/${NAME}-4.3.3-resolv-conf-path.patch.gz | patch -p1 -E --backup --verbose

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.6.2-gcc46.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.7.97-fix-for-g++47.patch

# support USE_SYSTEM_IRIS build option
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.10.0-kopete_system_iris.patch

# warning: dereferencing type-punned pointer will break strict-aliasing rules
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.10-kppp-strict-aliasing.patch

## upstreamable patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.10.4-krdc_icon.patch

## security patches

set +e +o pipefail
