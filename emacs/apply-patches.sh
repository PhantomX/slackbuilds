
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/glibc-open-macro.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/emacs-23.1-xdg.patch.gz | patch -p1 -E --backup --verbose
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/emacs-23.2-hideshow-comment.patch
# rhbz#713600
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/emacs-spellchecker.patch
# rhbz#711739
# http://bzr.savannah.gnu.org/lh/emacs/trunk/revision/106247
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/emacs-wm-state-hidden.patch
# rhbz#751154
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/emacs-xgselect.patch
# http://bzr.savannah.gnu.org/lh/emacs/trunk/revision/103228
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/103228_103227.diff

( cd site-lisp
  # rpm-spec-mode can use compilation-mode
  zcat ${SB_PATCHDIR}/rpm-spec-mode.patch.gz | patch -p0 -E --backup --verbose
  # rpm-spec-mode: added rpm-change-log-uses-utc variable
  zcat ${SB_PATCHDIR}/rpm-spec-mode-utc.patch.gz | patch -p0 -E --backup --verbose
)

set +e +o pipefail
