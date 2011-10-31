
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

zcat ${SB_PATCHDIR}/${NAME}-0.9.9.9-align.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-0.9.9.9-force64bit-tiger.patch.gz | patch -p1 -E --backup --verbose

# Taken from Gentoo: 
# http://mirror.its.uidaho.edu/pub/gentoo-portage/app-crypt/mhash/files/mhash-0.9.9-fix-snefru-segfault.patch
zcat ${SB_PATCHDIR}/${NAME}-0.9.9.9-fix-snefru-segfault.patch.gz | patch -p1 -E --backup --verbose
# http://mirror.its.uidaho.edu/pub/gentoo-portage/app-crypt/mhash/files/mhash-0.9.9-fix-mem-leak.patch
zcat ${SB_PATCHDIR}/${NAME}-0.9.9.9-fix-mem-leak.patch.gz | patch -p1 -E --backup --verbose
# http://mirror.its.uidaho.edu/pub/gentoo-portage/app-crypt/mhash/files/mhash-0.9.9-fix-whirlpool-segfault.patch
zcat ${SB_PATCHDIR}/${NAME}-0.9.9.9-fix-whirlpool-segfault.patch.gz | patch -p1 -E --backup --verbose
# http://mirror.its.uidaho.edu/pub/gentoo-portage/app-crypt/mhash/files/mhash-0.9.9-autotools-namespace-stomping.patch
zcat ${SB_PATCHDIR}/${NAME}-0.9.9.9-autotools-namespace-stomping.patch.gz | patch -p1 -E --backup --verbose
# End - Taken from Gentoo

# Taken from openpkg:
# http://www.mail-archive.com/openpkg-cvs@openpkg.org/msg26353.html
zcat ${SB_PATCHDIR}/${NAME}-0.9.9.9-maxint.patch.gz | patch -p1 -E --backup --verbose
# Taken from Jitesh Shah
# http://ftp.uk.linux.org/pub/armlinux/fedora/diffs-f11/mhash/0001-Alignment-fixes.patch
zcat ${SB_PATCHDIR}/${NAME}-0.9.9.9-alignment.patch.gz | patch -p1 -E --backup --verbose
# Fix keygen_test
zcat ${SB_PATCHDIR}/${NAME}-0.9.9.9-keygen_test_fix.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
