
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Set to test (some patches require others, so, is not 100%)
DRYRUN=${DRYRUN:-NO}

if [ "${DRYRUN}" = "YES" ] ; then
  DRYRUN_OPT="--dry-run"
fi

if [ "${VERBOSE}" = "YES" ] ; then
  VERBOSE_OPT="--verbose"
fi

if [ "${SVERBOSE}" = "YES" ] ; then
  set -o xtrace
fi

PATCHCOM="patch ${DRYRUN_OPT} -p1 -F1 -s ${VERBOSE_OPT}"

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

## upstream patches
ApplyPatch 0002-Texmap-GTK-The-poster-circle-doesn-t-appear.patch
ApplyPatch 0003-Qt-Tiled-backing-store-not-clipped-to-frame-or-visib.patch
ApplyPatch 0004-Qt-Images-scaled-poorly-on-composited-canvas.patch
ApplyPatch 0005-Port-of-r118587-to-TextBreakIteratorQt.cpp.patch
ApplyPatch 0006-JSC-ARM-traditional-failing-on-Octane-NavierStokes-t.patch
ApplyPatch 0007-Correct-range-used-for-Emoji-checks.patch
ApplyPatch 0008-Qt-RepaintRequested-signal-sometimes-not-emitted.patch
ApplyPatch 0009-TexMap-Remove-ParentChange-in-TextureMapperLayer.patch
ApplyPatch 0010-SVG-stroke-dasharray-not-working.patch
ApplyPatch 0011-Texmap-CSS-filter-not-working-on-software-composited.patch
ApplyPatch 0012-Do-not-try-to-compile-header-files-it-causes-weird-b.patch
ApplyPatch 0014-Fix-crash-when-converting-QObjectList.patch
ApplyPatch 0015-WebGL-EFL-Qt-GTK-Jelly-fishes-leave-trails-on-webgl-.patch
ApplyPatch 0016-Extend-disabling-of-whole-program-optimizations-to-M.patch
ApplyPatch 0017-OS-X-Mavericks-Xcode5-Find-libxslt-and-libxml2-heade.patch
ApplyPatch 0018-Fix-QtWebKit-build-on-ARM-softfp.patch
ApplyPatch 0019-Mouseup-event-does-not-fire-on-Scroll-Bar.patch
ApplyPatch 0020-Make-it-possible-to-build-without-using-build-webkit.patch

# search /usr/lib{,64}/mozilla/plugins-wrapped for browser plugins too
ApplyPatch webkit-qtwebkit-2.2-tp1-pluginpath.patch

# smaller debuginfo s/-g/-g1/ (debian uses -gstabs) to avoid 4gb size limit
ApplyPatch qtwebkit-2.3-debuginfo.patch

# tweak linker flags to minimize memory usage on "small" platforms
ApplyPatch qtwebkit-2.3-save_memory.patch

case "${ARCH}" in
  s390*)
    # use SYSTEM_MALLOC on ppc/ppc64, plus some additional minor tweaks (needed only on ppc? -- rex)
    ApplyPatch qtwebkit-ppc.patch
    # add missing function Double2Ints(), backport
    # rebased for 2.3.1, not sure if this is still needed?  -- rex
    ApplyPatch qtwebkit-23-LLInt-C-Loop-backend-ppc.patch
    ;;
esac

# fix build when using bison3
# https://qt.gitorious.org/qt/qtwebkit/commit/60ba8bd5b3575d
ApplyPatch glslang_bison3.patch

# support aarch64
ApplyPatch qtwebkit-aarch64.patch 

ApplyPatch qtwebkit-2.3.3

set +e +o pipefail
