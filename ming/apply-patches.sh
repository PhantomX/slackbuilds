
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup -z .dso --verbose -i ${SB_PATCHDIR}/ming-0.4.3-dso.patch
patch -p0 -E --backup -z .perl514 --verbose -i ${SB_PATCHDIR}/ming-0.4.3-perl514.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ming-0.4.3-libpng-1.5.patch

set +e +o pipefail
