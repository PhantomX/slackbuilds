
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/obconf-trans.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/obconf-spinner.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/01-freedesktop-compliance.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/02-show-specific-tab.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/03-button-layout.patch

set +e +o pipefail
