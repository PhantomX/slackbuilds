
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Suppress warnings about varargs macros for -pedantic
zcat ${SB_PATCHDIR}/glib-1.2.10-isowarning.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/glib-1.2.10-gcc34.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/glib-1.2.10-underquoted.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/glib-1.2.10-no_undefined.patch.gz | patch -p1 -E --backup --verbose
# http://bugzilla.redhat.com/222296
zcat ${SB_PATCHDIR}/glib-1.2.10-multilib.patch.gz | patch -p1 -E --backup --verbose
# Fix unused direct shared library dependency on libgmodule for libgthread
zcat ${SB_PATCHDIR}/glib-1.2.10-unused-dep.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
