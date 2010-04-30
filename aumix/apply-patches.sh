
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

for patch in $(< debian/patches/series) ;do
  patch -p1 -E --backup --verbose -i debian/patches/${patch}
done

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/aumix-2.8-include-signal_h.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/aumix-fix-cursor-color-on-exit.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/aumix-2.8-bug-115869.patch

set +e +o pipefail
