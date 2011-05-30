
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Using /usr/lib${LIBDIRSUFFIX}/psi/plugins directory for psimedia demo
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-demo.patch
# http://code.google.com/p/psi-dev/source/browse/trunk/patches/psimedia/0040-psimedia-2.6.38-compilation-fix.diff
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-remove-v4l.patch
# https://bugs.gentoo.org/show_bug.cgi?id=361419#c5
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-drop-v4lsrc-gst-plugin.patch

set +e +o pipefail
