
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.6.0-cachegrind-improvements.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.6.0-openat.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.6.0-glibc-2.10.1.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.6.0-helgrind-race-supp.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.6.0-amd64-loopnel.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.6.0-stat_h.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.6.0-config_h.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.6.0-capget.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.6.0-glibc-2.13.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.6.0-s390x-1.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.6.0-s390x-2.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.6.0-s390x-3.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.6.0-s390x-4.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.6.0-strcasecmp.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.6.0-xlc_dbl_u32-test-patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.6.0-helgrind-tests.patch

set +e +o pipefail
