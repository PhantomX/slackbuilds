
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -R -E --backup --verbose -i ${SB_PATCHDIR}/0001-unit-fix-complementing-of-requirement-deps-with-Afte.patch
# some post-v37 patches from upstream:
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-manager-fix-a-crash-in-isolating.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0005-systemctl-completion-always-invoke-with-no-legend.patch

set +e +o pipefail
