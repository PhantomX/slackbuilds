
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-syslibdirs.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-installP.patch
# Completion of NSS-based SSL implementation. Sent upstream. #714
# (combined with two tiny fixes from RHBZ #666022)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-des3-implement.patch
# When the above patches will  be consolidated upstream, this should merge
# with Patch1 or Patch2 or something like that
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-forkdaemon.patch
# Reopened http://bugs.bitlbee.org/bitlbee/ticket/738
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-systemd.patch

set +e +o pipefail
