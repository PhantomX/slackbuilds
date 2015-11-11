
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/donLogToFileBeforeFileLogsInitiate.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fileLogInitializationError-1.6.patch

set +e +o pipefail
