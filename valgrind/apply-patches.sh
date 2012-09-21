
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.8.0-cachegrind-improvements.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.8.0-openat.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.8.0-helgrind-race-supp.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.8.0-stat_h.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.8.0-config_h.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.8.0-capget.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.8.0-pie.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.8.0-enable-armv5.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.8.0-ldso-supp.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.8.0-x86-backtrace.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.8.0-find-buildid.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.8.0-cfi_dw_ops.patch

set +e +o pipefail
