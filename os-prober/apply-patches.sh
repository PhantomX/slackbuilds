
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Patches from Fedora
# move newns binary outside of os-prober subdirectory, so that debuginfo
# can be automatically generated for it
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-newnsdirfix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-no-dummy-mach-kernel.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-mdraidfix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-yaboot-parsefix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-usrmovefix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-remove-basename.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-disable-debug-test.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-btrfsfix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-bootpart-name-fix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-mounted-partitions-fix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-factor-out-logger.patch


set +e +o pipefail
