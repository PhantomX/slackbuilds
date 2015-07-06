
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

ApplyPatch use-python2.patch

# search /usr/lib{,64}/mozilla/plugins-wrapped for browser plugins too
ApplyPatch webkit-qtwebkit-2.2-tp1-pluginpath.patch

# smaller debuginfo s/-g/-g1/ (debian uses -gstabs) to avoid 4gb size limit
ApplyPatch qtwebkit-2.3-debuginfo.patch

if [ $(awk '/^MemTotal:/ { print $2 }' /proc/meminfo) -lt 4200000 ] ;then
  # tweak linker flags to minimize memory usage on "small" platforms
  ApplyPatch qtwebkit-2.3-save_memory.patch
  export BINUTILS_LD=bfd
fi

case "${ARCH}" in
  s390*)
    # use SYSTEM_MALLOC on ppc/ppc64, plus some additional minor tweaks (needed only on ppc? -- rex)
    ApplyPatch qtwebkit-ppc.patch
    # add missing function Double2Ints(), backport
    # rebased for 2.3.1, not sure if this is still needed?  -- rex
    ApplyPatch qtwebkit-23-LLInt-C-Loop-backend-ppc.patch
    ;;
esac

# truly madly deeply no rpath please, kthxbye
ApplyPatch webkit-qtwebkit-23-no_rpath.patch

## upstream patches
# backport from qt5-qtwebkit
# qtwebkit: undefined symbol: g_type_class_adjust_private_offset
# https://bugzilla.redhat.com/show_bug.cgi?id=1202735
ApplyPatch webkit-qtwebkit-23-gcc5.patch
# backport from qt5-qtwebkit: URLs visited during private browsing show up in WebpageIcons.db
ApplyPatch webkit-qtwebkit-23-private_browsing.patch

set +e +o pipefail
