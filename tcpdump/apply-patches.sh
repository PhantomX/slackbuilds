
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-icmp6-print-Reachable-Time-and-Retransmit-Time-from-.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-Use-getnameinfo-instead-of-gethostbyaddr.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-Drop-root-priviledges-before-opening-first-savefile-.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0007-Introduce-nn-option.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0008-Don-t-print-out-we-dropped-root-we-are-always-droppi.patch

set +e +o pipefail
