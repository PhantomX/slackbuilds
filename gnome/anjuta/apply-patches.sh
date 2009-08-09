  
SB_PATCHDIR=${CWD}/patches

# http://bugzilla.gnome.org/575147
zcat ${SB_PATCHDIR}/${NAME}-2.26.2.2-class-gen-templates.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/581074
zcat ${SB_PATCHDIR}/${NAME}-2.26.2.2-wxwidgets-project.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/582710
zcat ${SB_PATCHDIR}/${NAME}-2.26.2.2-reduce-wakeups.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/588506
zcat ${SB_PATCHDIR}/${NAME}-2.26.2.2-docdir.patch.gz | patch -p1 -E --backup --verbose || exit 1
