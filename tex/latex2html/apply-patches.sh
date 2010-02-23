
SB_PATCHDIR=${CWD}/patches

# patch latex2html to support tabularx environments better
zcat ${SB_PATCHDIR}/${NAME}-2K.1beta-tabularx.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Patch from Oliver Paukstadt <oliver.paukstadt@millenux.com>
zcat ${SB_PATCHDIR}/teTeX-l2h-config.patch.gz | patch -p2 -E --backup --verbose || exit 1
# Fix latex2html not to use DB_File
zcat ${SB_PATCHDIR}/${NAME}-2K.1beta-DB.patch.gz | patch -p2 -E --backup --verbose || exit 1
# fix SHLIBDIR
zcat ${SB_PATCHDIR}/${NAME}-2002-2-1-SHLIB.patch.gz | patch -p1 -E --backup --verbose || exit 1
# don't require the font directory to be ended with PATH/fonts
zcat ${SB_PATCHDIR}/${NAME}-2002-2-1-gsfont.patch.gz | patch -p1 -E --backup --verbose || exit 1
