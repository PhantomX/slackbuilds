
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-clarify-dlm-license.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.1.9-avoid-vorbis-save-crash.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.1.9-avoid-invalid-argument-crash.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.1.9-avoid-double-gfile-unref.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.1.9-fix-log-format-date-leak.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.1.9-fix-parse-date-leak.patch

# Set to YES if autogen is needed
SB_AUTOGEN=NO

set +e +o pipefail
