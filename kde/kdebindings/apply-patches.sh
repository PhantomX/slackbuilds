
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch 

zcat ${SB_PATCHDIR}/${NAME}-len-ptr-rfloat.diff.gz | patch -p1 --verbose
zcat ${SB_PATCHDIR}/${NAME}-ruby-env.h.diff.gz | patch -p1 --verbose
zcat ${SB_PATCHDIR}/${NAME}-rubyconfig.h.diff.gz | patch -p1 --verbose

## upstreamable patches
# fix errors found by valgrind
patch -p1 --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.5.2-generator-invalid-reads.patch

## upstream
# http://bugs.gentoo.org/332503
patch -p3 --backup --verbose -i ${SB_PATCHDIR}/pykde4.patch

set +e +o pipefail
