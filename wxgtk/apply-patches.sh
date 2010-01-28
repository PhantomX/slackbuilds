  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/wxGTK-2.8.7-mmedia.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/wxGTK-2.6.3-unicode-odbc.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/wxGTK-2.8.10.1-CVE-2009-2369.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://trac.wxwidgets.org/ticket/10883
zcat ${SB_PATCHDIR}/wxGTK-2.8.10-gsocket.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://trac.wxwidgets.org/ticket/11315 (#494425)
zcat ${SB_PATCHDIR}/wxGTK-2.8.10-wxTimer-fix.patch.gz | patch -p0 -E --backup --verbose || exit 1
# http://trac.wxwidgets.org/ticket/11310 (#528376)
zcat ${SB_PATCHDIR}/wxGTK-2.8.10-menubar-height.patch.gz | patch -p0 -E --backup --verbose || exit 1
