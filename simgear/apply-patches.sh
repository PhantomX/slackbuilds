
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# upstream a81dd2adf
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/simgear-2.8.0-fix-underlinking.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-add-more-arches.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-nuke-old-bundled-copy-of-expat-use-system-expat.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0004-check-to-be-sure-that-n-is-not-being-set-as-format-t.patch

set +e +o pipefail
