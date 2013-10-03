
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
[ "${SB_PAM}" = "YES" ] && patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-conf-pam.patch

### Fedora
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/cap-setuid-bug3945.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.3.4rc1-mod_vroot-test.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.3.4-utf8.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.3.4a-bug3720.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.3.4c-bug3744.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.3.4a-bug3745.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.3.4a-bug3746.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.3.4d-bug3973.patch

set +e +o pipefail
