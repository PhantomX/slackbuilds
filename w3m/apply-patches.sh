
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
zcat ${SB_PATCHDIR}/w3m-0.4.1-helpcharset.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/w3m-0.5.1-gcc4.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/w3m-0.5.3-multilib.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/bug_555467_FTBFS.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/bug_566101_Fix-DSO-X11.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/w3m-0.5.2-ssl_verify_server_on.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/w3m-0.5.2-glibc2.14-fix_file_handle_error.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/w3m-rh707994-fix-https-segfault.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/w3m-0.5.3-parallel-make.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/w3m-0.5.3-format-security.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/w3m-0.5.3-FTBFS-sys-errlist.patch

set +e +o pipefail
