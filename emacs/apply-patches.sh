
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/glibc-open-macro.patch.gz | patch -p1 -E --backup --verbose
# rhbz#713600
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/emacs-spellchecker.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/emacs-locate-library.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/emacs-nogets.patch

( cd site-lisp
  # rpm-spec-mode can use compilation-mode
  zcat ${SB_PATCHDIR}/rpm-spec-mode.patch.gz | patch -p0 -E --backup --verbose
  # rpm-spec-mode: added rpm-change-log-uses-utc variable
  zcat ${SB_PATCHDIR}/rpm-spec-mode-utc.patch.gz | patch -p0 -E --backup --verbose
  patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/rpm-spec-mode-changelog.patch
)

set +e +o pipefail
