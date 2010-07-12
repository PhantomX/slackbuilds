
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-scanplugins.patch.gz | sed \
  -e "s|_LIB_|${LIBDIRSUFFIX}|g" | patch -p0 -E --backup --verbose || exit 1
  
set +e +o pipefail
