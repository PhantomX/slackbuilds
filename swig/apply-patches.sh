
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/swig-1.3.23-pylib.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/swig203-rh706140.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/swig204-rh753321.patch
#patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/swig204-rh752054.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/swig204-rh679948.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/swig204-rh770696.patch

set +e +o pipefail
