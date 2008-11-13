  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-0.18.0-gmodulehack.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Quote in configure.in appropriately for recent libtool
zcat ${SB_PATCHDIR}/${NAME}-0.22.0-acquote.patch.gz | patch -p1 -E --backup --verbose || exit 1

( cd gdk-pixbuf && tar -xvzf ${CWD}/local-hack-gmodule2.tar.gz ) || exit 1

# Patches backported from GTK+ HEAD
zcat ${SB_PATCHDIR}/${NAME}-0.22.0-bmp-colormap.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.22.0-ico-width.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-underquoted.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=150601
zcat ${SB_PATCHDIR}/${NAME}-0.22.0-bmploop.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=130711
zcat ${SB_PATCHDIR}/${NAME}-0.22.0-loaders.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/gtk+-2.2.2-noexecstack.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.22.0-bmpcrash.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.22.0-xpm-largecol.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.22.0-xpm-ncol-overflow.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.22.0-xpm-whc-overflow.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Modular X moves rgb.txt
zcat ${SB_PATCHDIR}/${NAME}-0.22.0-rgb.patch.gz | patch -p1 -E --backup --verbose || exit 1
# multilib fixes
zcat ${SB_PATCHDIR}/${NAME}-0.22.0-multilib.patch.gz | patch -p1 -E --backup --verbose || exit 1

