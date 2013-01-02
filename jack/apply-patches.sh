
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# No-date-footer hack to remove dates from doxygen documentation
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/jack-audio-connection-kit-no_date_footer.patch
# Build fix
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/jack-doxygen-output-dir-fix.patch
# We don't want the internal API documentation
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/jack-apidoc-only.patch
# Fix doxygen doc build regression. From upstream trunk 95a1162d6aecc91
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/jack-doxygen-buildfix.patch
# Adjust default priority. RHBZ#795094
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/jack-realtime-compat.patch
# Enable renaming and reordering the jack ports RHBZ#887408
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/jack-portnames.patch
# Fix ppc64 mpd startup issue RHBZ#799552
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/jack-ppc64-long.patch

set +e +o pipefail
