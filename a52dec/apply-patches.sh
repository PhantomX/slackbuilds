
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### RPMFusion
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/a52dec-configure-optflags.patch
zcat ${SB_PATCHDIR}/a52dec-0.7.4-rpath64.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/liba52-silence.patch

set +e +o pipefail
