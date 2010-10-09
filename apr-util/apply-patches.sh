
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-1.2.7-pkgconf.patch.gz | patch -p1 -E --backup --verbose
#zcat${SB_PATCHDIR}/${NAME}-1.3.7-nodbmdso.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
