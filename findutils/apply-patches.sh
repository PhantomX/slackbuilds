
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.0-no-locate.patch
if [ "${SB_DEF}" = "YES" ] ;then
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.no.default.options.warnings.diff
fi

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
