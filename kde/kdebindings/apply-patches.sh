
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch 

zcat ${SB_PATCHDIR}/${NAME}-len-ptr-rfloat.diff.gz | patch -p1 --verbose
zcat ${SB_PATCHDIR}/${NAME}-ruby-env.h.diff.gz | patch -p1 --verbose
zcat ${SB_PATCHDIR}/${NAME}-rubyconfig.h.diff.gz | patch -p1 --verbose

## upstreamable patches
patch -p1 --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.5.1-RUBY_VERSION.patch

set +e +o pipefail
