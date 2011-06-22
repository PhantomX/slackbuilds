
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gcc-4.6.diff
sed -e "s|_SFMLSOVER_|${SFMLSOVER}|g" ${SB_PATCHDIR}/sfml-1.6-system-libs.patch \
 | patch -p0 -E --backup -z .sys --verbose

set +e +o pipefail
