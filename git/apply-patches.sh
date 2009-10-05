  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/git-1.5-gitweb-home-link.patch.gz | patch -p1 -E --backup --verbose || exit 1
# https://bugzilla.redhat.com/490602
zcat ${SB_PATCHDIR}/git-cvsimport-Ignore-cvsps-2.2b1-Branches-output.patch.gz | patch -p1 -E --backup --verbose || exit 1
# https://bugzilla.redhat.com/500137
zcat ${SB_PATCHDIR}/git-1.6-update-contrib-hooks-path.patch.gz | patch -p1 -E --backup --verbose || exit 1
