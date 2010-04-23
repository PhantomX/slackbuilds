
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/rule_generator.patch.gz | patch -p1 --verbose
patch -p1 --verbose -i ${SB_PATCHDIR}/udev-151-rules.patch
patch -p1 --verbose -i ${SB_PATCHDIR}/udev-151-gperf.patch

set +e +o pipefail
