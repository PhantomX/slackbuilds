  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}.patch.gz | patch -p0 -E --backup --verbose || exit 1
# Fix for x86_64 (does not hurt the other archs but note that we will start
# using /etc/pango/$host instead of /etc/pango/ now):
zcat ${SB_PATCHDIR}/pango.etc.host.location.diff.gz | patch -p1 --verbose || exit 1
