  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/gettext-0.17-open-args.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/gettext-0.17-autopoint-CVS-441481.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/gettext-0.17-rpathFix.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/gettext-xgettext-python-unicode-surrogate-473946.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/gettext-0.17-long-long-int-m4.patch.gz | patch -p0 -E --backup --verbose || exit 1
