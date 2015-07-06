
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Gentoo
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.4.16_p1969-pthread.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.4.17_p2055-test.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.4.17_p2055-gentoo.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.4.17_p2055-CSocketMultiplexer.patch

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fix-incompetence.patch

set +e +o pipefail
