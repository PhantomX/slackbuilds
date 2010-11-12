
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

#patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/backport.warnings.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/backport.rhbz650503.patch
chmod u+x tests/arabic.test

set +e +o pipefail
