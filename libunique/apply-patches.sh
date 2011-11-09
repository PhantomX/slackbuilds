
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Include NUL terminator in unique_message_data_get_filename()
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.1.6-include-terminator.patch
# test-unique: Resolve format string issues
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.1.6-fix-test.patch
# Remove compiler warnings
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.1.6-compiler-warnings.patch
# Remove G_CONST_RETURN usage, now that its gone in glib.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.1.6-G_CONST_RETURN.patch

set +e +o pipefail
