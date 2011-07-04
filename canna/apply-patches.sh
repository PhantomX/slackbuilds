
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${PNAME}-conf.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${PNAME}-3.6-sharedir.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${PNAME}-3.6-dont-grab-ctrl-o.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${PNAME}-3.6-fix-warnings.patch.gz | patch -p1 -E --backup --verbose
## some dictionaries were ported from SKK-JISYO.*
zcat ${SB_PATCHDIR}/skk-dictionaries.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${PNAME}-3.6-cannadic.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${PNAME}-3.6-shion.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${PNAME}-3.6-bonobo.patch.gz | patch -p1 -E --backup --verbose
# Fix for buffer overrun
zcat ${SB_PATCHDIR}/${PNAME}-3.6-wconv.patch.gz | patch -p1 -E --backup --verbose
if [ "${ARCH}" = "x86_64" ] ;then
  zcat ${SB_PATCHDIR}/${PNAME}-x86_64.patch.gz | patch -p1 -E --backup --verbose
fi
zcat ${SB_PATCHDIR}/${PNAME}-3.7p1-notimeout.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${PNAME}-oldsock.patch.gz | patch -p1 -E --backup --verbose
# Patch from the upstream
zcat ${SB_PATCHDIR}/${PNAME}-3.7p1-fix-duplicated-strings.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${PNAME}-3.7p3-yenbs.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${PNAME}-3.7p3-redecl.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${PNAME}-3.7p3-fix-gcc4-warning.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-3.7p3-no-strip.patch

set +e +o pipefail
