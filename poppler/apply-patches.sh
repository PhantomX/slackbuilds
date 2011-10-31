
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# http://bugzilla.redhat.com/show_bug.cgi?id=480868
#patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/poppler-0.12.4-annot-appearance.patch
# poppler-glib-demo, drop extraneous g_thread_init
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/poppler-0.18.1-glib.patch

# fix poppler-glib.pc
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/poppler-0.18.1-pkgconfig_GLIB_REQUIRED.patch

set +e +o pipefail
