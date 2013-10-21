
set -e -o pipefail

# The set of patches from hell :)

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# http://gcc.gnu.org/bugzilla/show_bug.cgi?id=56754

# From Fedora or upstream
patch -p0 -E --backup -z .hack --verbose -i ${SB_PATCHDIR}/gcc48-hack.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc48-rh330771.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc48-libgomp-omp_h-multilib.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc48-libtool-no-rpath.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc48-cloog-dl.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc48-cloog-dl2.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc48-pr38757.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc48-libstdc++-docs.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc48-no-copy-dt-needed-entries.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc48-pr56564.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc48-pr56493.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gcc48-dup3-typo.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gcc48-pr58800.patch

# From Gentoo
patch -p1 -E --backup -z .fortify --verbose -i ${SB_PATCHDIR}/10_all_default-fortify-source.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/15_all_libgfortran-Werror.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/16_all_libgomp-Werror.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/50_all_libiberty-asprintf.patch

### Arch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc-4.8-filename-output.patch

# Test CLSOVER
CLSORVER="$(grep -F 'libcloog-isl.so.' ${SB_PATCHDIR}/gcc48-cloog-dl.patch |awk -F\" '{print $2}' | cut -d. -f3)"
if [ "${CLSOVER}" != "${CLSORVER}" ] ;then
  echo "cloog-dl version mismatch. You have CLSOVER ${CLSORVER} in"
  echo "${SB_PATCHDIR}/gcc48-cloog-dl.patch instead ${CLSOVER}."
  echo "Change CLSOVER and try again"
  exit 1
fi
unset CLSORVER

set +e +o pipefail
