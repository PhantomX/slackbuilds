
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
if [ "${SB_SLKART}" = "YES" ] ;then
  zcat ${SB_PATCHDIR}/xfwm4-4.6.0-clearlooks.patch.gz | patch -p1 --verbose
fi

set +e +o pipefail
