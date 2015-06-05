
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

# hack out largely useless (to users) warnings about qdbusconnection
# (often in kde apps), keep an eye on https://git.reviewboard.kde.org/r/103699/
ApplyPatch qtbase-opensource-src-5.5.1-qdbusconnection_no_debug.patch

##upstream patches

# https://bugzilla.redhat.com/show_bug.cgi?id=1083664
# https://bugreports.qt.io/browse/QTBUG-42985
ApplyPatch qtbase-opensource-src-5.4.0-QTBUG-42985.patch

# https://bugzilla.redhat.com/show_bug.cgi?id=1219173
# https://bugreports.qt.io/browse/QTBUG-33093
# https://codereview.qt-project.org/#/c/95219/
ApplyPatch qtbase-opensource-src-5.4.1-QTBUG-33093.patch

# https://bugreports.qt.io/browse/QTBUG-45484
# QWidget::setWindowRole does nothing
# adapted to apply on top of patch51
ApplyPatch qtbase-opensource-src-5.4.1-QTBUG-45484.patch

# https://bugreports.qt.io/browse/QTBUG-46310
#SM_CLIENT_ID property is not set
ApplyPatch 0002-xcb-set-SM_CLIENT_ID-property.patch

# workaround https://bugreports.qt-project.org/browse/QTBUG-43057
# 'make docs' crash on el6, use qSort instead of std::sort
ApplyPatch qtbase-opensource-src-5.4.0-QTBUG-43057.patch

# Qt 5.5 patches
ApplyPatch qt5-qtbase-5.5-Get_display_number_when_screen_number_is_omitted.patch

set +e +o pipefail
