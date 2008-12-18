  
SB_PATCHDIR=${CWD}/patches

# FS#10836: fixes backgroundcolor parsing with gnome
zcat ${SB_PATCHDIR}/mozbug421977.patch.gz | patch -p0 -E --backup --verbose || exit 1

# Upstream patches
