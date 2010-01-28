  
SB_PATCHDIR=${CWD}/patches

# Might as well link to -lz -lm, since the ./configure seems
# to be doing it that way now...  finally.  That'll prevent
# a couple of emails a week.  :-)
zcat ${SB_PATCHDIR}/libpng.libs.diff.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/libpng-1.2.36-pngconf-setjmp.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/libpng-multilib.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/libpng-pngconf.patch.gz | patch -p1 --verbose || exit 1
