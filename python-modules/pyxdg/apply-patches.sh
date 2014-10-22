
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/pyxdg-wine.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pyxdg-0.25-find-first-mimetype-match.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sec-patch-CVE-2014-1624.patch

set +e +o pipefail
