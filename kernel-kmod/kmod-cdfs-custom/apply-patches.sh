
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/cdfs-2.6.19-kernel-2.6.22.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
