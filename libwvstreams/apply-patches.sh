
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${PNAME}-4.2.2-multilib.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${PNAME}-4.5-noxplctarget.patch.gz | patch -p1 -E --backup --verbose
#Fix parallel build (#226061)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-4.6.1-make.patch
#sys/stat.h is missing some files in rawhide build
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-4.6.1-statinclude.patch
#const X509V3_EXT_METHOD * -> X509V3_EXT_METHOD * conversion not allowed
#by rawhide gcc
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-4.6.1-gcc.patch
# fix missing unistd.h header for gcc 4.7
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-4.6.1-gcc47.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-4.6.1-magic.patch

set +e +o pipefail
