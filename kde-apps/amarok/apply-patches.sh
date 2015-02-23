
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## upstream patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0004-Code-cleanup-and-added-comments.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0014-Fix-compilation-and-linking-issues.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0039-Optimization-Don-t-draw-more-than-necessary.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0070-Rewrite-Block-Analyzer-to-use-pure-OpenGL-instead-of.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0071-Fix-rendering-glitch-introduced-with-commit-f4a3f4f.patch

set +e +o pipefail
