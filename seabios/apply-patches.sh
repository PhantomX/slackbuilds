
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/seabios-0.6.2-build.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/seabios-0.6.2-fix-QXL.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/seabios-do-not-advertise-S4-S3-in-DSDT.patch

set +e +o pipefail
