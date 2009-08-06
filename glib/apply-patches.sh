  
SB_PATCHDIR=${CWD}/patches

# Suppress warnings about varargs macros for -pedantic
zcat ${SB_PATCHDIR}/glib-1.2.10-isowarning.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/glib-1.2.10-gcc34.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/glib-1.2.10-underquoted.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/glib-1.2.10-no_undefined.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugzilla.redhat.com/222296
zcat ${SB_PATCHDIR}/glib-1.2.10-multilib.patch.gz | patch -p1 -E --backup --verbose || exit 1
