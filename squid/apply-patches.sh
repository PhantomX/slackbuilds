
SB_PATCHDIR=${CWD}/patches

#http://www.squid-cache.org/Versions/v3/3.0/changesets/b9052.patch
zcat ${SB_PATCHDIR}/b9052.patch.gz | patch -p0 -E --backup --verbose || exit 1
# http://www.squid-cache.org/Versions/v3/3.0/changesets/b9053.patch
zcat ${SB_PATCHDIR}/b9053.patch.gz | patch -p0 -E --backup --verbose || exit 1

zcat ${SB_PATCHDIR}/${NAME}-3.0.STABLE1-config.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.0.STABLE1-location.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.0.STABLE15-build.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.0.STABLE1-perlpath.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.0.STABLE15-smb-path.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.0.STABLE7-from_manpg.patch.gz | patch -p1 -E --backup --verbose || exit 1
