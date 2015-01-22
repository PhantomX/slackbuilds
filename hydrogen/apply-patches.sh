
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-devel-warning.patch
sed -e "s|__SB_LIBDIR__|lib${LIBDIRSUFFIX}|g" \
  ${SB_PATCHDIR}/${NAME}-ladspa-libdir.patch | patch -p0 -E --backup --verbose

set +e +o pipefail
