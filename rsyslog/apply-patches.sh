
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-5.8.9-systemd-slk.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-5.8.7-sysklogd-compat-1-template.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-5.8.7-sysklogd-compat-2-option.patch

set +e +o pipefail
