  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-strstr-const.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Make utils.checkPyQtImport() look for the gui sub-package.
zcat ${SB_PATCHDIR}/${NAME}-ui-optional.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Make sure to avoid handwritten asm.
zcat ${SB_PATCHDIR}/${NAME}-no-asm.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Fixed hp-setup traceback when discovery page is skipped.
zcat ${SB_PATCHDIR}/${NAME}-discovery-method.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Give up trying to print a job to a reconnected device 
zcat ${SB_PATCHDIR}/${NAME}-device-reconnected.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Avoid busy loop in hpcups when backend has exited.
zcat ${SB_PATCHDIR}/${NAME}-hpcups-sigpipe.patch.gz | patch -p1 -E --backup --verbose || exit 1
