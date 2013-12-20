
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# support USE_SYSTEM_IRIS build option
patch -p1 -E --backup -z .kopete_system_iris --verbose -i ${SB_PATCHDIR}/${NAME}-4.11.95-system_iris.patch

set +e +o pipefail
