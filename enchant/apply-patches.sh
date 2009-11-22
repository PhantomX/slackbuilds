  
SB_PATCHDIR=${CWD}/patches

#http://bugzilla.abisource.com/show_bug.cgi?id=12160
zcat ${SB_PATCHDIR}/${NAME}-1.5.0-abi12160.searchdirs.patch.gz | patch -p1 -E --backup --verbose || exit 1
#http://bugzilla.abisource.com/show_bug.cgi?id=12173
zcat ${SB_PATCHDIR}/${NAME}-1.5.0-abi12173.leaks.patch.gz | patch -p1 -E --backup --verbose || exit 1
#http://bugzilla.abisource.com/show_bug.cgi?id=12174
zcat ${SB_PATCHDIR}/${NAME}-1.5.0-abi12174.fixbadmatch.patch.gz | patch -p1 -E --backup --verbose || exit 1
