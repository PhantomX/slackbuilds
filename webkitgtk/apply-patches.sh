
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/webkit-1.3.10-nspluginwrapper.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}//0001-Build-fix-with-newer-bison-2.6.patch

set +e +o pipefail
