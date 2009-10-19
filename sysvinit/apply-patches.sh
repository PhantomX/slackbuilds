  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}.diff.gz | patch -p1 -E --backup --verbose || exit 1
# Unlink /.autofsck on shutdown -f
zcat ${SB_PATCHDIR}/${NAME}-2.86-autofsck.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Fix single user mode (#176348)
zcat ${SB_PATCHDIR}/${NAME}-2.86-single.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Be less verbose when booted with 'quiet'
zcat ${SB_PATCHDIR}/${NAME}-2.86-quiet.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Fix various things in pidof - pidof /x/y matching /z/y, pidof -x
# for scripts, etc.
zcat ${SB_PATCHDIR}/${NAME}-2.87-pidof.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Document some of the behavior of pidof. (#201317)
zcat ${SB_PATCHDIR}/${NAME}-2.86-pidof-man.patch.gz | patch -p1 -E --backup --verbose || exit 1
