
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## Fedora
# fix a typo in setfacl(1) man page (#675451)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-acl-2.2.49-bz675451.patch
# use pkg version in $(PKG_DOC_DIR)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-acl-2.2.52-docdir.patch
# prepare the test-suite for SELinux and arbitrary umask
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-acl-2.2.52-tests.patch
# Install the libraries to the appropriate directory
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0004-acl-2.2.52-libdir.patch
# fix SIGSEGV of getfacl -e on overly long group name
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0005-acl-2.2.52-getfacl-segv.patch

set +e +o pipefail
