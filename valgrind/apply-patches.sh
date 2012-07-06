
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.7.0-cachegrind-improvements.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.7.0-openat.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.7.0-helgrind-race-supp.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.7.0-stat_h.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.7.0-config_h.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.7.0-capget.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.7.0-glibc-2.16.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.7.0-pie.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.7.0-tests.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.7.0-f-sgetown-ex.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.7.0-scsi-ioctls.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.7.0-enable-armv5.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.7.0-ldso-supp.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.7.0-unspecified-type.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.7.0-rvalue-ref.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.7.0-debug-leak1.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.7.0-debug-leak2.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.7.0-addToXA.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.7.0-debug-types.patch
touch memcheck/tests/dw4.stdout.exp

set +e +o pipefail
