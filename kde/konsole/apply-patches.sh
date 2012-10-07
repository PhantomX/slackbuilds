
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# revert upstream commit setting Path=$HOME, it's non-portable
patch -p1 -E -R --backup --verbose -i ${SB_PATCHDIR}/0004-Specify-HOME-as-working-directory-through-the-.deskt.patch

set +e +o pipefail
