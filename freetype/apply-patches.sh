
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# This breaks far too many things.  Freetype2 developers will have to get their
# punishment on someone else's distribution.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/freetype.illadvisederror.diff

# Bytecode interpreter
# Upstream default is enabled
if [ "${SB_BCI}" != "YES" ] ; then
   patch -p1 -R -E --backup --verbose -i ${SB_PATCHDIR}/freetype.bytecode.interpreter.diff
fi

# The line below enables code patented by Microsoft, so don't uncomment it
# unless you have a license to use the code and take all legal responsibility
# for doing so.
[ "${SB_SPR}" = "YES" ] && patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/freetype.subpixel.rendering.diff

# Assorted fixes for 2.1.10 (thanks to Frederic Crozat)
# CVS bug fixes, mostly for embolding
zcat ${SB_PATCHDIR}/freetype-2.2.1-enable-valid.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup -z .multilib --verbose -i ${SB_PATCHDIR}/freetype-multilib.patch

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-autofit-Fix-use-of-dumping-functions-in-ftgrid-demo-.patch

set +e +o pipefail
