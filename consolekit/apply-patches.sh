  
SB_PATCHDIR=${CWD}/patches

# Clean up at_console compat files, bug #257761
zcat ${SB_PATCHDIR}/${NAME}-0.2.10-cleanup_console_tags.patch.gz | patch -p1 -E --backup --verbose || exit 1
