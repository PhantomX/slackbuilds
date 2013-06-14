
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-systemd-slk.patch
## Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-7.2.2-manpage-dbg-mode.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-7.2.1-msg_c_nonoverwrite_merge.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-7.3.15-imuxsock-warning.patch
# merged upstream
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-7.4.0-imjournal-segv.rhbz971471.patch
# merged upstream
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-7.4.0-ratelimiter-loop.rhbz971471.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-7.4.0-ratelimiter-loop2.rhbz971471.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-7.4.0-ratelimiter-reset.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-7.4.0-no-ste-file-segv.patch

set +e +o pipefail
