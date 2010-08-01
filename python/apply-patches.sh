
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}.readline.set_pre_input_hook.diff.gz | patch -p1 --verbose

# From Gentoo
for patches in \
  05_all_verbose_building_of_extensions.patch \
  06_all_non-zero_exit_status_on_failure.patch \
  21_all_distutils_c++.patch \
  22_all_turkish_locale.patch \
  ;do
  patch -p0 --backup --verbose -i ${PDIR}/${patches}
done

if [ "${ARCH}" = "x86_64" ]; then
  # Install to lib64 instead of lib:
  patch -p1 -E --backup -z .lib64 --verbose -i ${SB_PATCHDIR}/python-2.7rc1-lib64-slk.patch
  patch -p1 -E --backup -z .lib64 --verbose -i ${SB_PATCHDIR}/python-2.7-lib64-sysconfig.patch
  # Python must report /usr/lib64/python2.6/site-packages as python_lib_dir:
  zcat ${SB_PATCHDIR}/${NAME}.pure64.diff.gz |  patch -p1 --verbose
fi

# From Fedora
#patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/python-2.7rc1-config.patch
zcat ${SB_PATCHDIR}/${NAME}-2.5-cflags.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.5.1-plural-fix.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.5.1-sqlite-encoding.patch.gz | patch -p1 -E --backup --verbose
# Add various constants to the socketmodule:
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/python-2.7rc1-socketmodule-constants.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/python-2.7rc1-socketmodule-constants2.patch
zcat ${SB_PATCHDIR}/${NAME}-2.6-rpath.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/python-2.6.4-distutils-rpath.patch.gz | patch -p1 -E --backup --verbose

zcat ${SB_PATCHDIR}/python-2.3.4-lib64-regex.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/python-2.7rc1-ctypes-noexecmem.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/python-2.7rc1-no-static-lib.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/python-2.6.5-more-configuration-flags.patch
# Add flags for statvfs.f_flag to the constant list in posixmodule (i.e. "os")
# (rhbz:553020); partially upstream as http://bugs.python.org/issue7647
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/python-2.7rc1-statvfs-f_flag-constants.patch

# Make "pydoc -k" more robust in the face of broken modules
# (rhbz:461419; patch sent upstream as http://bugs.python.org/issue7425 )
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/make-pydoc-more-robust-001.patch

# Fix an incompatibility between pyexpat and the system expat-2.0.1 that led to
# a segfault running test_pyexpat.py (rhbz:583931)
# Sent upstream as http://bugs.python.org/issue9054
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/python-2.6.5-fix-expat-issue9054.patch

patch -p0 -R -E --backup --verbose -i ${SB_PATCHDIR}/python-2.7rc2-r79310.patch

# Fix race condition in parallel make that could lead to graminit.c failing
# to compile, or linker errors with "undefined reference to
# `_PyParser_Grammar'":
# Not yet sent upstream:
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/python-2.7-fix-parallel-make.patch

# Fix traceback in 2to3 on "from itertools import *"
# This is http://bugs.python.org/issue8892 (see also rhbz#600036)
# Cherrypicked from r82530 upstream:
( cd Lib
  patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/python-2.7-fix-2to3-itertools-import-star.patch
)

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/python-2.7-autotool-intermediates.patch

set +e +o pipefail
