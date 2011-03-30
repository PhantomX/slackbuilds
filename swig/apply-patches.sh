
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/swig-1.3.23-pylib.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/swig200-rh623854.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/swig200-rh666429.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/swig202-rh691513.patch

set +e +o pipefail
