
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Patches from Fedora
## upstreamable patches
# add pkgconfig support
# add 'make install' target
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/iris-1.0.0-install.patch
# Build shared library
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/iris-1.0.0-sharedlib.patch
# unbundle libidn, use system copy
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/iris-1.0.0-system_libidn.patch
mv src/libidn src/libidn.BAK
# install jdns
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/iris-1.0.0-jdns_install.patch

## rebased patches from kopete
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/iris-1.0.0-003_case_insensitive_jid.patch
# 109 changes abi, need to bump soname
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/iris-1.0.0-009_filetransferpreview.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/iris-1.0.0-014_fix_semicolons.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/iris-1.0.0-023_jingle.patch
# followup to patch123, to install new headers
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/iris-1.0.0-install_jingle.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/iris-1.0.0-024_fix_semicolons_and_iterator.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/iris-1.0.0-027_add_socket_access_function.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/iris-1.0.0-030_xep_0115_hash_attribute.patch

set +e +o pipefail
