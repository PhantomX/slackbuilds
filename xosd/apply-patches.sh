
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${CWD}/${PSRCARCHIVE} | patch -p1 -E --backup --verbose
for patch in \
  20_underquoted_definition.diff \
  ; do
  patch -p1 -E --backup --verbose -z .pdeb -i debian/patches/${patch}
done
zcat ${SB_PATCHDIR}/${NAME}-defaults.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
