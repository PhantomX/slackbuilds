
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# Set to test (some patches require others, so, is not 100%)
PATCH_DRYRUN=${PATCH_DRYRUN:-NO}

unset PATCH_DRYRUN_OPT PATCH_VERBOSE_OPT

[ "${PATCH_DRYRUN}" = "YES" ] && PATCH_DRYRUN_OPT="--dry-run"
[ "${PATCH_VERBOSE}" = "YES" ] && PATCH_VERBOSE_OPT="--verbose"
[ "${PATCH_SVERBOSE}" = "YES" ] && set -o xtrace

PATCHCOM="patch ${PATCH_DRYRUN_OPT} -p1 -F1 -s ${PATCH_VERBOSE_OPT}"

ApplyPatch() {
  local patch=$1
  shift
  if [ ! -f ${SB_PATCHDIR}/${patch} ]; then
    exit 1
  fi
  echo "Applying ${patch}"
  case "${patch}" in
  *.bz2) bzcat "${SB_PATCHDIR}/${patch}" | ${PATCHCOM} ${1+"$@"} ;;
  *.gz) zcat "${SB_PATCHDIR}/${patch}" | ${PATCHCOM} ${1+"$@"} ;;
  *) ${PATCHCOM} ${1+"$@"} -i "${SB_PATCHDIR}/${patch}" ;;
  esac
}

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

# support multilib optflags
ApplyPatch qtbase-multilib_optflags.patch -z .multilib-optflags
rm -fv mkspecs/linux-g++*/qmake.conf.multilib-optflags

# upstreamable patches
# fix QTBUG-35459 (too low entityCharacterLimit=1024 for CVE-2013-4549)
ApplyPatch qtbase-opensource-src-5.3.2-QTBUG-35459.patch

# unconditionally enable freetype lcdfilter support
ApplyPatch qtbase-opensource-src-5.2.0-enable_ft_lcdfilter.patch

##upstream patches

# https://bugzilla.redhat.com/show_bug.cgi?id=1083664
# https://bugreports.qt.io/browse/QTBUG-42985
ApplyPatch qtbase-opensource-src-5.4.0-QTBUG-42985.patch

# workaround https://bugreports.qt-project.org/browse/QTBUG-43057
# 'make docs' crash on el6, use qSort instead of std::sort
ApplyPatch qtbase-opensource-src-5.4.0-QTBUG-43057.patch

# Qt 5.5 patches
ApplyPatch qt5-qtbase-5.5-Get_display_number_when_screen_number_is_omitted.patch

ApplyPatch 0012-Fix-a-crash-in-QPlainTextEdit-documentChanged.patch
ApplyPatch 0072-CMake-Fix-QObject-connect-failing-on-ARM.patch
ApplyPatch 0094-Fix-Meta-.-shortcuts-on-XCB.patch
ApplyPatch 0132-Call-ofono-nm-Registered-delayed-in-constructor-othe.patch
ApplyPatch 0136-Make-sure-there-s-a-scene-before-using-it.patch
# http://lists.qt-project.org/pipermail/announce/2015-February/000059.html
# CVE-2015-0295
ApplyPatch 0149-Fix-a-division-by-zero-when-processing-malformed-BMP.patch
# CVE-2015-1858, CVE-2015-1859, CVE-2015-1860
ApplyPatch 0200-Fixes-crash-in-gif-image-decoder.patch
ApplyPatch 0201-Fixes-crash-in-bmp-and-ico-image-decoding.patch

set +e +o pipefail
