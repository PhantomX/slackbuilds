
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/rule_generator.patch
#patch -p1 --verbose -i ${SB_PATCHDIR}/udev-151-gperf.patch

set +e +o pipefail
