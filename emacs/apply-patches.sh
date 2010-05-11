
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/glibc-open-macro.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/emacs-23.1-xdg.patch.gz | patch -p1 -E --backup --verbose

( cd site-lisp
  # rpm-spec-mode can use compilation-mode
  zcat ${SB_PATCHDIR}/rpm-spec-mode.patch.gz | patch -p0 -E --backup --verbose
  # rpm-spec-mode: added rpm-change-log-uses-utc variable
  zcat ${SB_PATCHDIR}/rpm-spec-mode-utc.patch.gz | patch -p0 -E --backup --verbose
)

set +e +o pipefail
