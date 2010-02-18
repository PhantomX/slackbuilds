  
SB_PATCHDIR=${CWD}/patches

# for texlive/pdftex, make ObjStream class public
zcat ${SB_PATCHDIR}/poppler-0.12.1-objstream.patch.gz | patch -p1 -E --backup --verbose || exit 1
# image scaling with cairo poor (http://bugs.freedesktop.org/show_bug.cgi?id=5589)
zcat ${SB_PATCHDIR}/poppler-0.12.3-downscale.patch.gz | patch -p1 -E --backup --verbose || exit 1
# https://bugzilla.redhat.com/show_bug.cgi?id=533992
zcat ${SB_PATCHDIR}/poppler-0.12.3-actualize-fcconfig.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugs.freedesktop.org/show_bug.cgi?id=26264
# http://bugzilla.redhat.com/show_bug.cgi?id=563353
zcat ${SB_PATCHDIR}/poppler-0.12.3-rotated-downscale.patch.gz | patch -p1 -E --backup --verbose || exit 1
