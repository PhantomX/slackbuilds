
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/lame-noexecstack.patch.gz | patch -p1 -E --backup --verbose

# Patch gtk stuff, otherwise eautoreconf dies
zcat ${SB_PATCHDIR}/lame-3.98-gtk-path.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
