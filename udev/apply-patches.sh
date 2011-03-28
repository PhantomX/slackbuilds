
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/rule_generator.patch
#patch -p1 --verbose -i ${SB_PATCHDIR}/udev-151-gperf.patch
patch -p1 -R -E --backup --verbose -i ${SB_PATCHDIR}/udev.git-560de575148b7efda3b34a7f7073abd483c5f08e.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/udev-164-no-v4l1.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/udev-98ab6a377285d5943563cfa397e8b350e43878ec.patch

set +e +o pipefail
