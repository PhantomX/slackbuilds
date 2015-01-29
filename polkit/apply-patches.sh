
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# https://bugs.freedesktop.org/show_bug.cgi?id=71894
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/polkit-0.112-XDG_RUNTIME_DIR.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/polkit-0.112-systemd209.patch
# http://cgit.freedesktop.org/polkit/commit/?id=26d0c0578211fb96fc8fe75572aa11ad6ecbf9b8
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/polkit-0.112-systemd-Deduplicate-code-paths.patch
# http://cgit.freedesktop.org/polkit/commit/?id=a68f5dfd7662767b7b9822090b70bc5bd145c50c
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/polkit-0.112-systemd-prepare-for-D-Bus-user-bus.patch
# https://bugs.freedesktop.org/show_bug.cgi?id=88288
# http://cgit.freedesktop.org/polkit/commit/?id=f4d71e0de885010494b8b0b8d62ca910011d7544
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0018-authority-Fix-memory-leak-in-EnumerateActions-call-r.patch

for ignore in 01 05;do
  sed -i -e "/^${ignore}.*$/d" debian/patches/series
done
for i in $(<debian/patches/series); do
  patch -p1 --verbose --backup --suffix=".pdeb" -i debian/patches/${i}
done

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
