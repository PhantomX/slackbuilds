
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
zcat ${SB_PATCHDIR}/${NAME}-1.2.7-pkgconf.patch.gz | patch -p1 -E --backup --verbose
#patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.3.7-nodbmdso.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.4.1-private.patch

set +e +o pipefail
