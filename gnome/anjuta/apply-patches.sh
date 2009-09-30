  
SB_PATCHDIR=${CWD}/patches

# Lots of places where libxml cflags/libs are not being used (but are needed)
zcat ${SB_PATCHDIR}/${NAME}-2.27.92.0-libxml.patch.gz | patch -p1 -E --backup --verbose || exit 1
