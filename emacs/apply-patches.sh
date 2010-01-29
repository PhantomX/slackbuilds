  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/glibc-open-macro.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/emacs-gtk.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/emacs-23.1-xdg.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Fixed in upstream CVS.
zcat ${SB_PATCHDIR}/emacs-23.1-cpp.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/emacs-23.1-scroll.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/emacs-23.1-indian.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Fixed in upstream CVS
zcat ${SB_PATCHDIR}/emacs-23.1-memmove.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Taken from upstream GIT repository
# http://git.savannah.gnu.org/cgit/emacs.git/diff/src/xsettings.c?id=b3a25b88e82569f916712c635207c8bdd590e13b
# rhbz#517272
zcat ${SB_PATCHDIR}/emacs-23.1-fontdpi.patch.gz | patch -p1 -E --backup --verbose || exit 1

if pkg-config --exists libpng14 ;then
  zcat ${SB_PATCHDIR}/emacs-23.1-png14.patch.gz | patch -p0 -E --backup --verbose || exit 1
fi

( cd site-lisp || exit 1
  # rpm-spec-mode can use compilation-mode
  zcat ${SB_PATCHDIR}/rpm-spec-mode.patch.gz | patch -p0 -E --backup --verbose || exit 1
  # fix po-auto-replace-revision-date nil
  zcat ${SB_PATCHDIR}/po-mode-auto-replace-date-71264.patch.gz | patch -p0 -E --backup --verbose || exit 1
  # rpm-spec-mode: added rpm-change-log-uses-utc variable
  zcat ${SB_PATCHDIR}/rpm-spec-mode-utc.patch.gz | patch -p0 -E --backup --verbose || exit 1
) || exit 1
