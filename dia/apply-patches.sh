  
SB_PATCHDIR=${CWD}/patches

# Fix compilation in a gnome environment
zcat ${SB_PATCHDIR}/${NAME}-0.97.0-gnome-doc.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Fix compilation python
zcat ${SB_PATCHDIR}/${NAME}-0.97-acinclude-python-fixes.patch.gz | patch -p1 -E --backup --verbose || exit 1

