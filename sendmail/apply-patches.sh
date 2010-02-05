  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/sendmail-8.14.4-makemapman.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/sendmail-8.14.3-smrsh_paths.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/sendmail-8.13.7-pid-slk.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/sendmail-8.12.7-hesiod.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/sendmail-8.12.7-manpage.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/sendmail-8.14.4-dynamic.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/sendmail-8.13.0-cyrus.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/sendmail-8.14.4-aliases_dir.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/sendmail-8.13.7-vacation-slk.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/sendmail-8.14.1-noversion.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/sendmail-8.13.1-localdomain.patch.gz | patch -p1 -E --backup --verbose || exit 1
cp devtools/M4/UNIX/{,shared}library.m4
zcat ${SB_PATCHDIR}/sendmail-8.14.3-sharedmilter.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/sendmail-8.14.4-switchfile.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/sendmail-8.14.3-milterfdleaks.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/sendmail-8.14.3-ipv6-bad-helo.patch.gz | patch -p1 -E --backup --verbose || exit 1
