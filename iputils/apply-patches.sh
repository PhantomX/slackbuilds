
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-20020927-rh.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-20020927-ping-subint.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-ifenslave.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-20121121-ifaddrs.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-20121125-usage-before-caps.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-20121125-doc-tags.patch

set +e +o pipefail
