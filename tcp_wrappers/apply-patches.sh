
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tcpw7.2-config.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tcpw7.2-setenv.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tcpw7.6-netgroup.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tcp_wrappers-7.6-bug11881.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tcp_wrappers-7.6-bug17795.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tcp_wrappers-7.6-bug17847.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tcp_wrappers-7.6-fixgethostbyname.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tcp_wrappers-7.6-docu.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tcp_wrappers-7.6-man.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tcp_wrappers.usagi-ipv6.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tcp_wrappers.ume-ipv6.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tcp_wrappers-7.6-shared.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tcp_wrappers-7.6-sig.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tcp_wrappers-7.6-strerror.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tcp_wrappers-7.6-ldflags.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tcp_wrappers-7.6-fix_sig-bug141110.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tcp_wrappers-7.6-162412.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tcp_wrappers-7.6-220015.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tcp_wrappers-7.6-restore_sigalarm.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tcp_wrappers-7.6-siglongjmp.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tcp_wrappers-7.6-sigchld.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tcp_wrappers-7.6-196326.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tcp_wrappers_7.6-249430.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tcp_wrappers-7.6-inetdconf.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tcp_wrappers-7.6-bug698464.patch

set +e +o pipefail
