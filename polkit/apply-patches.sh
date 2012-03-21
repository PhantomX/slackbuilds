
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

for ignore in 01 05 ;do
  sed -i -e "/^${ignore}.*$/d" debian/patches/series
done
for i in $(<debian/patches/series); do
  patch -p1 --verbose --backup --suffix=".pdeb" -i debian/patches/${i}
done

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-PolkitUnixSession-Set-error-if-we-cannot-find-a-sess.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-PolkitUnixSession-Actually-return-TRUE-if-a-session-.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-PolkitAgentSession-Don-t-leak-file-descriptors.patch

set +e +o pipefail
