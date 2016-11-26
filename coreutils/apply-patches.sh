
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

unset PATCH_VERBOSE_OPT
[ "${PATCH_VERBOSE}" = "YES" ] && PATCH_VERBOSE_OPT="--verbose"
[ "${PATCH_SVERBOSE}" = "YES" ] && set -o xtrace

PATCHCOM="patch -p1 -s -F1 --backup ${PATCH_VERBOSE_OPT}"

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

# Patch in the uname for Linux enhancements
if [ "${SB_RHUNAME}" = "YES" ] ;then
  # Fedora/Red Hat patch.
  ApplyPatch ${NAME}-8.2-uname-processortype.patch
else
  # Slackware patch
  ApplyPatch ${NAME}.uname.diff.gz
fi

# From upstream

# Fedora patches
ApplyPatch ${NAME}-6.10-configuration.patch
# add note about no difference between binary/text mode on Linux - md5sum manpage
ApplyPatch ${NAME}-6.10-manpages.patch
#df --direct
ApplyPatch ${NAME}-df-direct.patch
#add note about mkdir --mode behaviour into info documentation(#610559)
ApplyPatch ${NAME}-8.4-mkdir-modenote.patch

# sh-utils
# add info about TZ envvar to date manpage
ApplyPatch sh-utils-2.0.11-dateman.patch
ApplyPatch ${NAME}-4.5.3-langinfo.patch

# (sb) lin18nux/lsb compliance
ApplyPatch ${NAME}-i18n.patch
# (sb) lin18nux/lsb compliance - expand/unexpand
ApplyPatch ${NAME}-i18n-expand-unexpand.patch
# i18n patch for cut - old version - used
ApplyPatch ${NAME}-i18n-cut-old.patch
# The unexpand patch above is not correct. Sent to the patch authors
ApplyPatch ${NAME}-i18n-fix-unexpand.patch
#(un)expand - allow multiple files on input - broken by patch 801
ApplyPatch ${NAME}-i18n-fix2-expand-unexpand.patch
#(un)expand - test BOM headers
ApplyPatch ${NAME}-i18n-un-expand-BOM.patch
# make 'sort -h' work for arbitrary column even when using UTF-8 locales
ApplyPatch ${NAME}-i18n-sort-human.patch

# getgrouplist() patch from Ulrich Drepper.
ApplyPatch ${NAME}-getgrouplist.patch
# Prevent buffer overflow in who(1).
ApplyPatch ${NAME}-overflow.patch

### upstream 
# fix 'sort -h -k' in locales that use blank as thousands separator (#1355780)
ApplyPatch ${NAME}-8.25-sort-thousands-sep.patch
# ls: allow interruption when reading slow directories (#1365933)
ApplyPatch ${NAME}-8.25-ls-signal.patch
# md5sum,sha*sum: fix --ignore-missing with checksums starting with 00
ApplyPatch ${NAME}-8.25-sum-ignore-missing.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
