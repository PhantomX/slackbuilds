
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/cegui-0.6.0-userverso.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/cegui-0.6.0-release-as-so-ver.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/cegui-0.6.2-new-DevIL.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cegui-0.6.2-new-tinyxml.patch

set +e +o pipefail
