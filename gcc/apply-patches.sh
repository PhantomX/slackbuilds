
set -e -o pipefail

# The set of patches from hell :)

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Prevents build error with 10_all_default-fortify-source.patch below
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc49-libitm-no-fortify.patch

# From Fedora or upstream
patch -p0 -E --backup -z .hack --verbose -i ${SB_PATCHDIR}/gcc49-hack.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc49-rh330771.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc49-libgomp-omp_h-multilib.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc49-libtool-no-rpath.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc49-cloog-dl.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc49-cloog-dl2.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc49-pr38757.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc49-libstdc++-docs.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc49-no-copy-dt-needed-entries.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc49-pr56493.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc49-color-auto.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc49-libgo-p224.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gcc.git-232ed3acfa618ffb50290f3a28bcc5bed1ded89e.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gcc49-pr61503.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gcc49-pr61537.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gcc49-pr61160.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gcc49-pr61614.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gcc49-pr61499.patch

# From Gentoo
patch -p1 -E --backup -z .fortify --verbose -i ${SB_PATCHDIR}/10_all_default-fortify-source.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/15_all_libgfortran-Werror.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/16_all_libgomp-Werror.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/17_all_libitm-Werror.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/18_all_libatomic-Werror.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/50_all_libiberty-asprintf.patch

### Arch
# http://gcc.gnu.org/bugzilla/show_bug.cgi?id=57653
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc-4.8-filename-output.patch

# Test CLSOVER
CLSORVER="$(grep -F 'libcloog-isl.so.' ${SB_PATCHDIR}/gcc49-cloog-dl.patch |awk -F\" '{print $2}' | cut -d. -f3)"
if [ "${CLSOVER}" != "${CLSORVER}" ] ;then
  echo "cloog-dl version mismatch. You have CLSOVER ${CLSORVER} in"
  echo "${SB_PATCHDIR}/gcc49-cloog-dl.patch instead ${CLSOVER}."
  echo "Change CLSOVER and try again"
  exit 1
fi
unset CLSORVER

set +e +o pipefail
