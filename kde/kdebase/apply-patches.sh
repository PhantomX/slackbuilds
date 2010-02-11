  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-4.1.80-nsplugins-paths.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-4.1.70-konsole-session.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-4.2.1-home-icon-slk.patch.gz | patch -p1 -E --backup --verbose || exit 1

## upstream patches
# remove extra spaces from konsole selections, https://bugzilla.redhat.com/560721
zcat ${SB_PATCHDIR}/${NAME}-4.3.95-konsole-extra-spaces.patch.gz | patch -p1 -E --backup --verbose || exit 1
