
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

sed -e "s|_SFMLSOVER_|${SFMLSOVER}|g" ${SB_PATCHDIR}/sfml-1.6-system-libs.patch \
 | patch -p0 -E --backup -z .sys --verbose

set +e +o pipefail
