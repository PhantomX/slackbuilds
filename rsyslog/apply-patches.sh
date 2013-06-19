
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-7.4.1-sd-service-slk.patch
## Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-7.2.2-manpage-dbg-mode.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-7.2.1-msg_c_nonoverwrite_merge.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-7.3.15-imuxsock-warning.patch

set +e +o pipefail
