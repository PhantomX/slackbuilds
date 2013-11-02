
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
### Fedora
ApplyPatch ${NAME}-3.9.0-cachegrind-improvements.patch
# KDE#211352 - helgrind races in helgrind's own mythread_wrapper
ApplyPatch ${NAME}-3.9.0-helgrind-race-supp.patch
ApplyPatch ${NAME}-3.9.0-stat_h.patch
ApplyPatch ${NAME}-3.9.0-ldso-supp.patch
# On some ppc64 installs these test just hangs
ApplyPatch ${NAME}-3.9.0-gdbserver_tests-mcinvoke-ppc64.patch
# KDE#326983 - insn_basic test might crash because of setting DF flag 
ApplyPatch ${NAME}-3.9.0-amd64_gen_insn_test.patch

set +e +o pipefail
