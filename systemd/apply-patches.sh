
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/udev-microsoft-3000-keymap.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Add-ifdef-guards-around-xattr-usage.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-cryptsetup-fix-nofail-support.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0004-catalog-correct-substitution.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-timedatectl-shorten-output-to-print-single-80-char-l.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-timedatctl-bring-manual-strftime-in-sync-with-format.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-timedatectl-show-both-current-actual-timezone-name-a.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-timedatectl-improve-english-language-DST-change-text.patch

set +e +o pipefail
