
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

IgnorePatch() {
  if [ -n "{IGNORE}" ] ;then
    for patchnumber in ${IGNORE} ;do
      sed -e "/^${patchnumber}/d" -i $1
    done
  fi
}

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
ApplyPatch 0001-tests-Try-several-UTF8-locales.patch
ApplyPatch 0002-maint-post-release-administrivia.patch
ApplyPatch 0003-libparted-also-link-to-UUID_LIBS.patch
ApplyPatch 0004-lib-fs-resize-Prevent-crash-resizing-FAT16-file-syst.patch
ApplyPatch 0005-tests-t3000-resize-fs.sh-Add-FAT16-resizing-test.patch
ApplyPatch 0006-tests-t3000-resize-fs.sh-Add-requirement-on-mkfs.vfa.patch
ApplyPatch 0007-tests-Change-minimum-size-to-256MiB.patch
ApplyPatch 0008-parted-don-t-crash-in-disk_set-when-disk-label-not-f.patch
ApplyPatch 0009-tests-Add-a-test-for-device-mapper-partition-sizes.patch
ApplyPatch 0010-libparted-device-mapper-uses-512b-sectors.patch
ApplyPatch 0011-Update-manpage-NAME-so-whatis-will-work.patch
ApplyPatch 0012-tests-Make-sure-the-extended-partition-length-is-2-1.patch
ApplyPatch 0013-libparted-BLKPG_RESIZE_PARTITION-uses-bytes-not-sect.patch
ApplyPatch 0014-parted-Fix-crash-with-name-command-and-no-disklabel-.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
