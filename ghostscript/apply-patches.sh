
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/ghostscript-8.62-versioned_ijs.patch.gz | patch -p0 --verbose

# Fix ijs-config not to have multilib conflicts
zcat ${SB_PATCHDIR}/ghostscript-multilib.patch.gz | patch -p1 --verbose
# Fix some shell scripts
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ghostscript-scripts.patch
# Build igcref.c with -O0 to work around bug rh#150771.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ghostscript-noopt.patch
# Fix ./autgen.sh in ijs sub-project
# Define .runlibfileifexists.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ghostscript-runlibfileifexists.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ghostscript-Fontmap.local.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ghostscript-system-openjpeg2.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ghostscript-system-zlib.patch

set +e +o pipefail
