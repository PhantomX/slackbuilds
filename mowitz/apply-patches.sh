
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-t1lib.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-0.3.0-overflow3.patch 
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-0.3.0-overflow4.patch 
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-0.3.0-overflow5.patch 
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-0.3.0-overflow6.patch 
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-0.3.0-overflow7.patch 
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-0.3.0-overflow8.patch 

set +e +o pipefail
