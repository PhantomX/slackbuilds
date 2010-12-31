
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch 

zcat ${SB_PATCHDIR}/${NAME}-len-ptr-rfloat.diff.gz | patch -p1 --verbose
zcat ${SB_PATCHDIR}/${NAME}-ruby-env.h.diff.gz | patch -p1 --verbose
zcat ${SB_PATCHDIR}/${NAME}-rubyconfig.h.diff.gz | patch -p1 --verbose

## upstreamable patches

## upstream
# http://bugs.gentoo.org/332503
patch -p3 --backup --verbose -i ${SB_PATCHDIR}/pykde4.patch
patch -p1 --backup --verbose -i ${SB_PATCHDIR}/sip4.12.patch
( cd python/pykde4/tools/pykdeuic4
  patch -p0 --backup --verbose -i ${SB_PATCHDIR}/pykdeuic4.patch
)

set +e +o pipefail
