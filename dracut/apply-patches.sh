
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0012-dracut.sh-also-mkdir-run-lock-which-is-copied-to.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0013-dracut.sh-no-need-to-make-subdirs-in-run.patch

set +e +o pipefail
