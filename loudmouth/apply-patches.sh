
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-1.4.3-certs_location.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-1.4.3-async_assertion.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-1.4.3-fix-sasl-md5-digest-uri.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Drop-stanzas-when-failing-to-convert-them-to-LmMessa.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.4.3-glib-compile-fix.patch
### Arch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gnutls-3.4.0.patch

set +e +o pipefail
