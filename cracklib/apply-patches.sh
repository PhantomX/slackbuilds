
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
cp -f lib/packer.h lib/packer.h.in
zcat ${SB_PATCHDIR}/cracklib-2.8.15-inttypes.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/cracklib-2.8.12-gettext.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cracklib-2.8.15-init.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cracklib-2.8.16-hi_update.patch

set +e +o pipefail
