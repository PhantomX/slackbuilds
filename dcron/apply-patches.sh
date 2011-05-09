
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Patched from stock Slackware
# Define TMPDIR as /var/spool/cron instead of /tmp
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/defs.h.TMPDIR.diff
# Fix problem where user creates /var/spool/cron/crontabs/<user>.new 
# using 'crontab -', exits with control-c, and then crontab refuses to
# overwrite the junk file.  It would be better if dcron would wipe
# the junk file in the event it were not closed correctly, but oh well.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/crontab.c.O_EXCL.diff

set +e +o pipefail
