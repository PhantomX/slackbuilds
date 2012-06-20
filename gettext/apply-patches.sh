
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gettext-readlink-einval.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gettext-0.18.1-fix-xgettext-crash.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gettext-0.18.1-automake.patch

set +e +o pipefail
