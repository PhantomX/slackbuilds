
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# http://bugs.gentoo.org/show_bug.cgi?id=264986
# Disable it if no connection.
#[ "${SB_MT}" = "YES" ] && patch -p1 -E --backup -z .mt --verbose -i ${SB_PATCHDIR}/${NAME}-0.1_beta10-mt.patch

### Debian
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fix-makefile-flags.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fix-fd-leak.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fix-memleaks.patch

# More fields on tooltip
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.1_beta10-more-tooltips.patch

set +e +o pipefail
