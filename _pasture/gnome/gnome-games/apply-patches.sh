
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
cat ${SB_PATCHDIR}/lsb-really.patch | sed \
 -e "s|_SLKDISTR_|${SLKDIST} Linux Project|g;s|_SLKDIST_|${SLKDIST}|g" \
 | patch -p1 -E --backup --verbose

set +e +o pipefail
