
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# https://bugs.kde.org/show_bug.cgi?id=318825
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-mediastreamer29.patch

# support USE_SYSTEM_IRIS build option
patch -p1 -E --backup -z .kopete_system_iris --verbose -i ${SB_PATCHDIR}/${NAME}-4.11.0-kopete_system_iris.patch

set +e +o pipefail
