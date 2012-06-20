
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.5.9-sgr.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.6.1-wildcards.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.6.1-so-links.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.6.2-automake.patch

set +e +o pipefail
