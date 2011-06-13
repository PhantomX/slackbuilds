
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libtirpc-0.2.1-fortify.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libtirpc-0.2.2-rpc-des-prot.patch
# https://bugs.gentoo.org/show_bug.cgi?id=370713
> src/des_crypt.c

set +e +o pipefail
