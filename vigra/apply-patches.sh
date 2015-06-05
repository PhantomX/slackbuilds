
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/vigra.rhbz987048.shebang.patch
 # https://github.com/ukoethe/vigra/pull/212
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/vigra.transparent-alpha-fix.patch

set +e +o pipefail
