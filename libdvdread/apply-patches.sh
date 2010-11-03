
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup -z .multilib --verbose -i ${SB_PATCHDIR}/libdvdread-multilib.patch
zcat ${SB_PATCHDIR}/04-md5-symbols.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
