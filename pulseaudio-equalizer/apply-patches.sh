
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Force default equalizer persistence value, fixes rhbz #635400
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.7-force-default-persistence-value.patch
# Remove preamp per discussion with upstrem, fixes rhbz #639604
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.7-remove-preamp.patch
# Better search for the window icon, fixes rhbz #632940
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.7-window-icon.patch
# Do not crash on missing preset, fixes rhbz ##679005
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.7-do-not-crash-on-missing-preset.patch

set +e +o pipefail
