
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## upstream me!  -- Rex :)
zcat ${SB_PATCHDIR}/${NAME}-4.2.98-kdrc-icon.patch.gz | patch -p1 -E --backup --verbose
# rhbz#540433 - KPPP is unable to add DNS entries to /etc/resolv.conf
zcat ${SB_PATCHDIR}/${NAME}-4.3.3-resolv-conf-path.patch.gz | patch -p1 -E --backup --verbose

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.6.2-gcc46.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.7.97-fix-for-g++47.patch

# support USE_SYSTEM_IRIS build option
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.10.0-kopete_system_iris.patch

# warning: dereferencing type-punned pointer will break strict-aliasing rules
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.10-kppp-strict-aliasing.patch

## upstreamable patches
# kernel-3.9.0 v4l deprecations
# see http://bugzilla.redhat.com/946924
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.10.2-v4l_deprecations.patch

## security patches

set +e +o pipefail
