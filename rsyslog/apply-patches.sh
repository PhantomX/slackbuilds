
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-6.4.0-systemd-slk.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-5.8.11-manpage-dbg-mode.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-5.8.11-enlarge-cert-info-bufs.patch

set +e +o pipefail
