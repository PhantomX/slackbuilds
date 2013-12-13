
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

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

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

# help build on some lowmem archs, e.g. drop hard-coded -O3 optimization on some files
ApplyPatch qtbase-opensource-src-5.0.2-lowmem.patch

# support multilib optflags
ApplyPatch qtbase-multilib_optflags.patch -z .multilib-optflags
rm -fv mkspecs/linux-g++*/qmake.conf.multilib-optflags

# qatomic on ppc/ppc64, http://bugzilla.redhat.com/1005482
ApplyPatch qtbase-qatomic-ppc.patch

# upstreamable patches
# fix big endian builds
ApplyPatch qtbase-opensource-src-5.1.1-bigendian.patch
# fix build with -system-harfbuzz
ApplyPatch qtbase-opensource-src-5.2.0-alpha-harfbuzz.patch

##upstream patches

set +e +o pipefail
