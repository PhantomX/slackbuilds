  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/alpine.manpage.diff.gz | patch -p1 --verbose || exit 1
# Correct paths and programs in tech-notes.txt:
zcat ${SB_PATCHDIR}/alpine.tech-notes.txt.diff.gz | patch -p1 --verbose || exit 1

# short-term workaround until gcc is fixed
# http://bugzilla.redhat.com/496400
zcat ${SB_PATCHDIR}/alpine-2.00-gcc44_reply_hack.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/alpine-2.00-hunspell.patch.gz | patch -p1 -E --backup --verbose || exit 1

( cd ${PGSRCDIR} || exit 1
  zcat ${SB_PATCHDIR}/pinepgp-0.18.0-makefile-sed-fix.diff.gz | patch -p1 --verbose || exit 1
  zcat ${SB_PATCHDIR}/pinepgp.pinegpgp.in.diff.gz | patch -p1 --verbose || exit 1
) || exit 1
