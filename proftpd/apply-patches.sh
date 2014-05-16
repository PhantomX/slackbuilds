
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
[ "${SB_PAM}" = "YES" ] && patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-conf-pam.patch

### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.3.4rc1-mod_vroot-test.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.3.4-utf8.patch

set +e +o pipefail
