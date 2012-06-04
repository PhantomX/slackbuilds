
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# move newns binary outside of os-prober subdirectory, so that debuginfo
# can be automatically generated for it
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-newnsdirfix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-no-dummy-mach-kernel.patch
# Sent upstream
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-mdraidfix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-grub2-fedorafix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-yaboot-parsefix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-usrmovefix.patch

set +e +o pipefail
