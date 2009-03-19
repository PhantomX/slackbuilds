
SB_PATCHDIR=${CWD}/patches

# http://bugzilla.redhat.com/474758
zcat ${SB_PATCHDIR}/${NAME}-2.24.0-catch-deviceadded.patch.gz | patch -p1 -E --backup --verbose || exit 1
