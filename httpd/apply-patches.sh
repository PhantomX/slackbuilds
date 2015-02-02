
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.4.1-confd.patch

# build/scripts patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/httpd-2.4.1-apctl.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/httpd-2.4.9-apxs.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/httpd-2.4.1-deplibs.patch
if [ "${SB_SYSTEMD}" = "YES" ] ;then
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/httpd-2.4.3-apctl-systemd.patch
  sed -i -e 's|/usr/bin/systemctl|/bin/systemctl|g' support/apachectl.in
fi
[ "${SB_SYSTEMD}" = "YES" ] && patch -p1 -E -F1 --backup --verbose -i ${SB_PATCHDIR}/httpd-2.4.10-detect-systemd.patch
# Features/functional changes
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/httpd-2.4.4-export.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/httpd-2.4.1-corelimit.patch
#patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/httpd-2.4.1-selinux.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/httpd-2.4.4-r1337344+.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/httpd-2.4.2-icons.patch
[ "${SB_SYSTEMD}" = "YES" ] && patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/httpd-2.4.10-mod_systemd.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/httpd-2.4.4-cachehardmax.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/httpd-2.4.4-sslmultiproxy.patch
[ "${SB_SYSTEMD}" = "YES" ] && patch -p1 -E -F1 --backup --verbose -i ${SB_PATCHDIR}/httpd-2.4.9-socket-activation.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/httpd-2.4.10-sslciphdefault.patch

# Bug fixes
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/httpd-2.4.4-malformed-host.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/httpd-2.4.4-mod_unique_id.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/httpd-2.4.10-sigint.patch

# Security fixes

set +e +o pipefail
