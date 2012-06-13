
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/docbook-xsl-pagesetup.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/docbook-xsl-marginleft.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/docbook-xsl-newmethods.patch
zcat ${SB_PATCHDIR}/docbook-xsl-non-constant-expressions.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/docbook-xsl-list-item-body.patch.gz | patch -p1 -E --backup --verbose
#workaround missing mandir section problem (#727251)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/docbook-xsl-mandir.patch

set +e +o pipefail
