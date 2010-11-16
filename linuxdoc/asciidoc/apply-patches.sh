
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# http://groups.google.com/group/asciidoc/browse_thread/thread/7f7a633c5b11ddc3
patch -p1 -E --backup -z .datadir --verbose -i ${SB_PATCHDIR}/${NAME}-8.6.3-datadir.patch

set +e +o pipefail
