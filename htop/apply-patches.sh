
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup -z .noplpa --verbose -i ${SB_PATCHDIR}/htop-0.9-system-plpa.patch
rm -rf plpa-*/

set +e +o pipefail
