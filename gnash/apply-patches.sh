
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## Fedora
# Patch0 :      http://www.mail-archive.com/gcc-bugs@gcc.gnu.org/msg338792.html
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.8.10-add-unistd-header.patch
# Patch1 :      Fix CVE-2012-1175
#               http://git.savannah.gnu.org/cgit/gnash.git/commit/?id=bb4dc77eecb6ed1b967e3ecbce3dac6c5e6f1527
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.8.10-integer-overflow.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.8.10-boost-1.50.patch

set +e +o pipefail
