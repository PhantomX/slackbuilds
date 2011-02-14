
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/apr-0.9.7-deepbind.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/apr-1.2.2-locktimeout.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/apr-1.2.2-libdir.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/apr-1.2.7-pkgconf.patch.gz | patch -p1 -E --backup --verbose
# Patch to fix aliasing issue exposed by gcc-4.5.1:
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/apr.apr_ring.h.gcc45.diff

set +e +o pipefail
