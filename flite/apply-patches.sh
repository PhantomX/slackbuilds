
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/flite-1.3-sharedlibs.patch
zcat ${SB_PATCHDIR}/flite-1.3-doc_texinfo.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/flite-1.3-alsa_support.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/flite-1.3-implicit_dso_linking.patch

set +e +o pipefail
