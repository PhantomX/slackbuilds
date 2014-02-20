
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# https://bugs.freedesktop.org/show_bug.cgi?id=71894
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/polkit-0.112-XDG_RUNTIME_DIR.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/polkit-0.112-systemd209.patch

for ignore in 01 05;do
  sed -i -e "/^${ignore}.*$/d" debian/patches/series
done
for i in $(<debian/patches/series); do
  patch -p1 --verbose --backup --suffix=".pdeb" -i debian/patches/${i}
done

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
