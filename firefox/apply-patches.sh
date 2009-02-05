  
SB_PATCHDIR=${CWD}/patches

# FS#10836: fixes backgroundcolor parsing with gnome
zcat ${SB_PATCHDIR}/mozbug421977.patch.gz | patch -p0 -E --backup --verbose || exit 1

zcat ${SB_PATCHDIR}/030-firefox_encode_spaces.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/667_typeahead-broken-v4.patch.gz | patch -p0 -E --backup --verbose || exit 1

# Upstream patches
