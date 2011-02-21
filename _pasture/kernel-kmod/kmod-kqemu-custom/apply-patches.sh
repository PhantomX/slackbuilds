
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/kqemu-1.3.0_pre11-sched_h.patch.gz | patch -p0 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/kqemu-1.4.0_pre1-init_MUTEX.patch

set +e +o pipefail
