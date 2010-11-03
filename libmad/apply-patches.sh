
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/libmad-0.15.1b-cflags.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/libmad-0.15.1b-cflags-O2.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
