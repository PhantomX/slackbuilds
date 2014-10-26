
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Gentoo
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.0_pre4-ac_check_sizeof.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.0_pre4-pthread.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.0_pre4-tinfo.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.0_pre4-tsent-set-but-not-used.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
