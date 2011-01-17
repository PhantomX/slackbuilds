
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/xxp-0.5.3.3-xklavier-api.patch.gz | patch -p1 -E --backup --verbose
# https://bugzilla.redhat.com/show_bug.cgi?id=525471
# fix at http://bugzilla.xfce.org/show_bug.cgi?id=6122#c1
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.5.3.3-fix-various-segfaults.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.5.3.3-fix-segfault-in-kb-selector.patch

set +e +o pipefail
