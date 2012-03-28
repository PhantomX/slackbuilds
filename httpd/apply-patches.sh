
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
sed -e "s#lib/httpd#lib${LIBDIRSUFFIX}/httpd#" ${SB_PATCHDIR}/config.layout.diff | patch --verbose -p0
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.4.1-confd.patch

# build/scripts patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/httpd-2.4.1-apctl.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/httpd-2.4.1-apxs.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/httpd-2.4.1-deplibs.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/httpd-2.4.1-apr14.patch
# Features/functional changes
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/httpd-2.4.1-export.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/httpd-2.4.1-corelimit.patch
#patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/httpd-2.4.1-selinux.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/httpd-2.4.1-suenable.patch

# Bug fixes

# Security fixes

set +e +o pipefail
