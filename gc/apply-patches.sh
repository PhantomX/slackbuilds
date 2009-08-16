  
SB_PATCHDIR=${CWD}/patches

# To be more backward-compatible abi-wise, TODO: upstream ml reference
#zcat ${SB_PATCHDIR}/gc-7.1-gcinit.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/gc-7.1-sparc.patch.gz | patch -p1 -E --backup --verbose || exit 1

## upstreamable patches
zcat ${SB_PATCHDIR}/gc-7.1-dup_cpp_headers.patch.gz | patch -p1 -E --backup --verbose || exit 1

## upstream patches
# http://www.hpl.hp.com/hosted/linux/mail-archives/gc/2008-May/002206.html
zcat ${SB_PATCHDIR}/gc-7.1-dont_add_byte.patch.gz | patch -p1 -E --backup --verbose || exit 1
