
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-PolkitUnixProcess-Clarify-that-the-real-uid-is-retur.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-Make-PolkitUnixProcess-also-record-the-uid-of-the-pr.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-Use-polkit_unix_process_get_uid-to-get-the-owner-of-.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0004-pkexec-Avoid-TOCTTOU-problems-with-parent-process.patch

for ignore in 00 01 ;do
  sed -i -e "/^${ignore}.*$/d" debian/patches/series
done
for i in $(<debian/patches/series); do
  patch -p1 --verbose --backup --suffix=".pdeb" -i debian/patches/${i}
done

set +e +o pipefail
