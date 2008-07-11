# patch latex2html to support tabularx environments better
zcat ${CWD}/${NAME}-2K.1beta-tabularx.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Patch from Oliver Paukstadt <oliver.paukstadt@millenux.com>
zcat ${CWD}/teTeX-l2h-config.patch.gz | patch -p2 -E --backup --verbose || exit 1
# Fix latex2html not to use DB_File
zcat ${CWD}/${NAME}-2K.1beta-DB.patch.gz | patch -p2 -E --backup --verbose || exit 1
# fix SHLIBDIR
zcat ${CWD}/${NAME}-2002-2-1-SHLIB.patch.gz | patch -p1 -E --backup --verbose || exit 1
# don't require the font directory to be ended with PATH/fonts
zcat ${CWD}/${NAME}-2002-2-1-gsfont.patch.gz | patch -p1 -E --backup --verbose || exit 1
