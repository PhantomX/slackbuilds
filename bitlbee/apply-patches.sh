
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
# When the above patches will  be consolidated upstream, this should merge
# with Patch1 or Patch2 or something like that
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-forkdaemon.patch
# Reopened http://bugs.bitlbee.org/bitlbee/ticket/738
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-systemd.patch
# This patch makes bitlbee to compile with libotr4.
# Originally from
# http://marc.info/?l=openbsd-ports&m=137656238506916&w=2
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/bitlbee-3.2-libotr4.patch
# Suggested fix for https://bugzilla.redhat.com/949303
# aka http://bugs.bitlbee.org/bitlbee/ticket/1008
# Open socket on IPv6 as well
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/bitlbee-IPv6.patch

set +e +o pipefail
