  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-1.0.5-new-ffmpeg.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.0.5-automake111.patch.gz | patch -p0 -E --backup --verbose || exit 1

zcat ${SB_PATCHDIR}/${NAME}-1.0.4-manualbufsize.patch.gz | patch -p1 -E --backup --verbose || exit 1

# 3rd time is a charm, https://bugs.kde.org/show_bug.cgi?id=156684#c30 
zcat ${SB_PATCHDIR}/reload-for-verification.diff.gz | patch -p0 -E --backup --verbose || exit 1
# put k3b-(iso,cue).desktop to xdg_apps_DATA , see http://bugzilla.redhat.com/419681
# upstreamed 2008-08-27
zcat ${SB_PATCHDIR}/${NAME}-1.0.5-hidden.patch.gz | patch -p1 -E --backup --verbose || exit 1

( cd ${I18SRCDIR} || exit 1
  zcat ${SB_PATCHDIR}/${I18NAME}-0.12.17-rellink.patch.gz | patch -p2 -E --backup --verbose || exit 1
) || exit 1
