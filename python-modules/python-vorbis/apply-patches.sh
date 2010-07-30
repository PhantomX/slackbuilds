
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${PNAME}-1.4-python2.5.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/pyogg-ticket2-fix.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
