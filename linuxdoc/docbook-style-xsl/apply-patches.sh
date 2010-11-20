
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/docbook-xsl-pagesetup.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/docbook-xsl-marginleft.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/docbook-xsl-newmethods.patch
zcat ${SB_PATCHDIR}/docbook-xsl-non-constant-expressions.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/docbook-xsl-list-item-body.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
