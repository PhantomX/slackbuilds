
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# https://bugzilla.redhat.com/show_bug.cgi?id=748228
# patch from http://git.xfce.org/apps/gigolo/commit/?id=0e53ec5c
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gigolo-0.4.1-fix-crash-748228.patch
# Update wscript to handle waf 1.6 (already upstream)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gigolo-0.4.1.wafupdate.patch

set +e +o pipefail
