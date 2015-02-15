
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
[ "${SB_SHARED}" = "YES" ] && patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gsoap-libtool.patch
### Mageia
[ "${SB_SHARED}" = "YES" ] || patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/Makefile.am.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gsoap-2.8.12-ssl.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gsoap-2.8-automake.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
