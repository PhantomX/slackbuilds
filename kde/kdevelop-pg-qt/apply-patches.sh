
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-set-LIB_INSTALL_DIR-even-with-no-KDE4-stuff.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-Some-std-string-support-in-iterators.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-bugfix-inserting-user-generated-code.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0004-add-CTest-CDash-config-for-KDevelop-PG-Qt.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0005-force-building-of-unit-tests.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0007-Fixed-the-bit-array-implementation-and-replaced-vect.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0008-Fixed-handling-of-overflows-in-TokenStream-read.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0009-Updated-generated-files.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0011-fix-some-warnings.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0012-updated-generated-files.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0013-Fix-some-clang-compiler-warnings.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0014-Fix-compile-with-clang-also-enable-exceptions-there.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0015-std-c-11-std-c-0x-to-fix-build-on-build.kde.org.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0016-Make-it-possible-to-build-without-tests.patch

set +e +o pipefail
