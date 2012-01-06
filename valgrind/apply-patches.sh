
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.6.1-cachegrind-improvements.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.6.1-openat.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.6.1-glibc-2.10.1.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.6.1-helgrind-race-supp.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.6.1-stat_h.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.6.1-config_h.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.6.1-capget.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.6.1-glibc-2.14.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.6.1-s390x-1.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.6.1-s390x-2.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.6.1-s390x-3.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.6.1-s390x-4.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.6.1-xlc_dbl_u32-test-patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.6.1-helgrind-tests.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.6.1-ppc64-pwrite64.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.6.1-pie.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.6.1-gen_insn_test.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.6.1-x86-ldso-strlen.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.6.1-ppc64-build.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.6.1-tests-_GNU_SOURCE.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0007-implement-extra-dwarf-ops-gcc-461.patch

set +e +o pipefail
