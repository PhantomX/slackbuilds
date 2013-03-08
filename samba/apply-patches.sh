
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/samba-4.0.3-fix_pidl_with_gcc48.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/samba-4.0.3-fix_pdb_ldapsam.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/samba-4.0.3-fix_libcmdline-credentials_linking.patch

set +e +o pipefail
