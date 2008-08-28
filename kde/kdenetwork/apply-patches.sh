  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-3.1-desktop.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.1-buildroot.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.2.3-resolv.patch.gz | patch -p1 -E --backup --verbose || exit 1
# include more/proper ppp headers
zcat ${SB_PATCHDIR}/${NAME}-3.5.9-ppp.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.5.9-krfb_httpd.patch.gz | patch -p1 -E --backup --verbose || exit 1

# KDEmod patches
zcat ${SB_PATCHDIR}/01_kcm-replace-ugly-kcmsambaconf-icon.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/02_kcm-fileshare.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/04_kopete-reloading-kit.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/05_kopete-emoticons-manager.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/06_kopete-fix-extra-line-break-in-jabber.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/07_kopete-fix-newlines-when-sending-richtext-icq.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/08_kopete-show-previous-status-messages.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/09_kopete-fix-translation-plugin.patch.gz | patch -p1 -E --backup --verbose || exit 1
