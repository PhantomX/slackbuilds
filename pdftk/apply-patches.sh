
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/pdftk.patch
zcat ${SB_PATCHDIR}/pdftk-1.41-gcc-4.3.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/pdftk-1.41-gcc-4.4.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/pdftk-1.41-honor-ldflags.patch.gz | patch -p1 -E --backup --verbose
find . -name Makefile -exec sed "s/-4.3//" -i "{}" \;
( cd java_libs
  # http://www.mail-archive.com/gcc-bugs@gcc.gnu.org/msg287911.html
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/makefile.patch
)

set +e +o pipefail
