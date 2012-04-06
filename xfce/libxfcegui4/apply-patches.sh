
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-4.4.2-xfce-exec-use-thunar.patch.gz | patch -p1 --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-xfce-4.10.patch

set +e +o pipefail
