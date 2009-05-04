  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-noexecstack.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-pmake.patch.gz | patch -p1 -E --backup --verbose || exit 1

# The frontened tries to link staticly, but we prefer shared libs
zcat ${SB_PATCHDIR}/${NAME}-3.98-shared-frontend.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Patch gtk stuff, otherwise eautoreconf dies
zcat ${SB_PATCHDIR}/${NAME}-3.98-gtk-path.patch.gz | patch -p0 -E --backup --verbose || exit 1

# Fix for ffmpeg-0.5, bug 265830
zcat ${SB_PATCHDIR}/${NAME}-3.98.2-ffmpeg-0.5.patch.gz | patch -p1 -E --backup --verbose || exit 1
