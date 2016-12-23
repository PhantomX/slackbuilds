
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
# Build changes
ApplyPatch openssl-1.1.0-build.patch
ApplyPatch openssl-1.1.0-defaults.patch
ApplyPatch openssl-1.1.0-no-html.patch

# Bug fixes
ApplyPatch openssl-1.1.0-issuer-hash.patch
ApplyPatch openssl-1.1.0-algo-doc.patch
ApplyPatch openssl-1.1.0-manfix.patch
ApplyPatch openssl-1.1.0-disable-threadstest.patch

# Functionality changes
ApplyPatch openssl-1.1.0-version-add-engines.patch
ApplyPatch openssl-1.1.0-apps-dgst.patch
ApplyPatch openssl-1.1.0-starttls-xmpp.patch
ApplyPatch openssl-1.1.0-chil-fixes.patch
ApplyPatch openssl-1.1.0-secure-getenv.patch
ApplyPatch openssl-1.1.0-ec-curves.patch
ApplyPatch openssl-1.1.0-no-md5-verify.patch
ApplyPatch openssl-1.1.0-cc-reqs.patch
ApplyPatch openssl-1.1.0-disable-ssl3.patch
ApplyPatch openssl-1.1.0-system-cipherlist.patch
ApplyPatch openssl-1.1.0-afalg-eventfd2.patch
ApplyPatch openssl-1.1.0-bio-fd-preserve-nl.patch
# Backported fixes including security fixes
ApplyPatch openssl-1.1.0-sslread-revert.patch
ApplyPatch openssl-1.1.0-cert-req.patch

# Use .so.${SSLSOVER}, not .so.${VERSION}:
sed -e "s|_SB_SOVER_|${SSLSOVER}|g" ${SB_PATCHDIR}/openssl.soname.diff \
  | patch -p1 --backup --verbose --suffix=.orig

# Upstream

set +e +o pipefail
