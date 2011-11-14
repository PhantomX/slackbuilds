
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/koffice-2.3.1-libwpg02.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/koffice-2.3.2-gcc46.patch
# https://bugzilla.redhat.com/show_bug.cgi?id=736659 - see upstream references (qt, kde)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/koffice-2.3.3-no-qdebug-pixmap.patch
# FTBFS against newer glib2
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/koffice-2.3.3-glib.patch
# https://bugs.kde.org/show_bug.cgi?id=267311
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/fix-inserting-required-value-2.3.patch
# http://bugs.kde.org/show_bug.cgi?id=267671
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/fix-form-color-properties-2.3.patch
# 
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/fix-crash-in-kexidb-queries-2.3.patch

set +e +o pipefail
