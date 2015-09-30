
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
sed \
  -e "s|_DEF_MIX_|${SB_DEF_MIX}|g" \
  -e "s|_TERM_MODE_|${SB_TERM_MODE}|g" \
  ${SB_PATCHDIR}/volti-0.2.3-prefs.patch | patch -p0 -E --backup -z .prefs --verbose 

set +e +o pipefail
