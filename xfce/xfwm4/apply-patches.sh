
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
if [ "${SB_SLKART}" = "YES" ] ;then
  zcat ${SB_PATCHDIR}/xfwm4-4.6.0-clearlooks.patch.gz | patch -p1 --verbose
fi
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xfwm4-4.9.0-desktop-fix.patch

set +e +o pipefail
