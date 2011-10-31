
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup -z .rb19 --verbose -i ${SB_PATCHDIR}/hivex-ruby19.patch

# Fix Perl directory install path.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/hivex-1.2.3-dirs.patch

# Upstream patch to fix building hivexsh, hivexget commands.
# Second patch is autoconf generated changes.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Fix-conditional-test-for-HAVE_HIVEXSH.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Fix-conditional-test-for-HAVE_HIVEXSH-autoconf.patch

set +e +o pipefail
