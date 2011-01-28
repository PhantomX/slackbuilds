
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch 
patch -p1 --verbose --backup -z .len_ptr -i ${SB_PATCHDIR}/${NAME}-len-ptr-rfloat.diff
patch -p1 --verbose --backup -z .rbenv -i ${SB_PATCHDIR}/${NAME}-ruby-env.h.diff
patch -p1 --verbose --backup -z .rbconfig -i ${SB_PATCHDIR}/${NAME}-rubyconfig.h.diff

## upstreamable patches
patch -p1 --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.5.95-valgrind.patch

## upstream
( cd python/pykde4/tools/pykdeuic4
  patch -p0 --backup --verbose -i ${SB_PATCHDIR}/pykdeuic4.patch
)

set +e +o pipefail
