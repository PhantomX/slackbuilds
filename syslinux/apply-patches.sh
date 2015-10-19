
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -d ${SRCDIR} -i ${SB_PATCHDIR}/0001-Add-install-all-target-to-top-side-of-HAVE_FIRMWARE.patch
# Backport from upstream git master to fix RHBZ #1234653
patch -p1 -E --backup --verbose -d ${SRCDIR} -i ${SB_PATCHDIR}/0035-SYSAPPEND-Fix-space-stripping.patch
# From upstream ML, these should fix some GCC 5 issues, e.g. RHBZ #1263988
# http://www.syslinux.org/archives/2015-September/024317.html
# http://www.syslinux.org/archives/2015-September/024318.html
patch -p1 -E --backup --verbose -d ${SRCDIR} -i ${SB_PATCHDIR}/fix-alignment-change-gcc-5.patch
# http://www.syslinux.org/archives/2015-September/024319.html
patch -p1 -E --backup --verbose -d ${SRCDIR} -i ${SB_PATCHDIR}/dont-guess-section-alignment.patch

set +e +o pipefail
