
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Make tests use shared instead of static libJudy
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/Judy-1.0.4-test-shared.patch
# The J1* man pages were incorrectly being symlinked to Judy, rather than Judy1
# This patch corrects that; submitted upstream 2008/11/27
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/Judy-1.0.4-fix-Judy1-mans.patch

set +e +o pipefail
