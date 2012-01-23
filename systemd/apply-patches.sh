
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-tmpfiles-fix-parsing-of-proc-net-unix-on-32Bit-machi.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-units-make-sure-syslog-socket-goes-away-early-during.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-readahead-don-t-monopolize-IO-when-replaying.patch

set +e +o pipefail
