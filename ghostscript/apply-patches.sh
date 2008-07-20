  
SB_PATCHDIR=${CWD}/patches

# Patch gs_res.ps to find resources in the correct directories:
zcat ${SB_PATCHDIR}/${NAME}-8.62.gs_res.ps.diff.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-8.62-versioned_ijs.patch.gz | patch -p0 --verbose || exit 1

zcat ${SB_PATCHDIR}/${NAME}-multilib.patch.gz | patch -p1 --verbose || exit 1
# Fix some shell scripts
zcat ${SB_PATCHDIR}/${NAME}-scripts.patch.gz | patch -p1 --verbose || exit 1
# Build igcref.c with -O0 to work around bug #150771.
zcat ${SB_PATCHDIR}/${NAME}-noopt.patch.gz | patch -p1 --verbose || exit 1
# Fix shared library build.
zcat ${SB_PATCHDIR}/${NAME}-fPIC.patch.gz | patch -p1 --verbose || exit 1
# Define .runlibfileifexists.
zcat ${SB_PATCHDIR}/${NAME}-runlibfileifexists.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-system-jasper.patch.gz | patch -p1 --verbose || exit 1
# Fix pksmraw output (bug #308211).
zcat ${SB_PATCHDIR}/${NAME}-pksmraw.patch.gz | patch -p1 --verbose || exit 1
# Applied patch from upstream to fix box_fill_path for shfill
zcat ${SB_PATCHDIR}/${NAME}-r8591.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-incomplete-ccittfax.patch.gz | patch -p1 --verbose || exit 1
