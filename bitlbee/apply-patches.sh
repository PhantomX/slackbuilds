
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
# When the above patches will  be consolidated upstream, this should merge
# with Patch1 or Patch2 or something like that
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-forkdaemon.patch
# Reopened http://bugs.bitlbee.org/bitlbee/ticket/738
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-systemd.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-fix-NULL-pointer-dereference.patch

set +e +o pipefail
