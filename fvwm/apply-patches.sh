# The set of patches from hell :)

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-xdg-open.patch.gz | patch -p1 -E --backup --verbose || exit 1
#zcat ${SB_PATCHDIR}/${NAME}-2.5.21-htmlview.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.5.21-mimeopen.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.5.21-menu-generate.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.5.24-module_list_remove.patch.gz | patch -p0 -E --backup --verbose || exit 1

# this patch enables fast translucent menus in fvwm. this is a
# minor tweak of a patch posted to fvwm-user mailing list by Olivier
# Chapuis in <20030827135125.GA6370@snoopy.folie>.
zcat ${SB_PATCHDIR}/${NAME}-2.5.23-translucent-menus.diff.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-menu-xlock-xlockmore-compat.diff.gz | patch -p1 -E --backup --verbose || exit 1
