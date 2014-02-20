
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.5.2-stack-smash.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.5.2-format_not_a_string_literal_and_no_format_arguments.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.5.2-default-archive-format.patch
### Arch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.5.3-fix-rpm-support.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.5.3-fix-double-escaping.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.5.3-fix-password-protected.patch

set +e +o pipefail
