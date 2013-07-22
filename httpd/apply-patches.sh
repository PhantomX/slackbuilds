
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.4.1-confd.patch

# build/scripts patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/httpd-2.4.1-apctl.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/httpd-2.4.3-apxs.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/httpd-2.4.1-deplibs.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/httpd-2.4.1-apr14.patch
# Features/functional changes
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/httpd-2.4.4-export.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/httpd-2.4.1-corelimit.patch
#patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/httpd-2.4.1-selinux.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/httpd-2.4.4-r1337344+.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/httpd-2.4.2-icons.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/httpd-2.4.4-r1332643+.patch
[ "${SB_SYSTEMD}" = "YES" ] && patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/httpd-2.4.3-mod_systemd.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/httpd-2.4.4-cachehardmax.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/httpd-2.4.4-sslmultiproxy.patch

# Bug fixes
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/httpd-2.4.3-sslsninotreq.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/httpd-2.4.4-dump-vhost-twice.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/httpd-2.4.4-malformed-host.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/httpd-2.4.4-mod_unique_id.patch

# Security fixes

set +e +o pipefail
