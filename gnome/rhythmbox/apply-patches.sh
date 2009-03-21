
SB_PATCHDIR=${CWD}/patches

# https://bugzilla.redhat.com/show_bug.cgi?id=428034
zcat ${SB_PATCHDIR}/rb-disable-power-plugin-by-default.patch.gz | patch -p0 -E --backup --verbose || exit 1
