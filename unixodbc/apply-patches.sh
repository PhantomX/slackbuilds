  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/depcomp.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/multilib-config.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/warning-cleanup.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/export-symbols.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/libtool-config.patch.gz | patch -p1 -E --backup --verbose || exit 1
rm -rf config.guess config.sub install-sh ltmain.sh libltdl
zcat ${SB_PATCHDIR}/so-version-bump.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/keep-typedefs.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${PNAME}-2.2.14-fix-export.patch.gz | patch -p0 -E --backup --verbose || exit 1
