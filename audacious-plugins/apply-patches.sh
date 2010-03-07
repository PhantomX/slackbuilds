
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-2.0.1-xmms-skindir.patch.gz | patch -p1 -E --backup --verbose
# merged upstream
zcat ${SB_PATCHDIR}/${NAME}-2.2-neon-request.patch.gz | patch -p1 -E --backup --verbose
# merged upstream
zcat ${SB_PATCHDIR}/${NAME}-2.2-cfg_db_close.patch.gz | patch -p1 -E --backup --verbose
# merged upstream
zcat ${SB_PATCHDIR}/${NAME}-2.2-bluetooth.patch.gz | patch -p1 -E --backup --verbose
# merged upstream
zcat ${SB_PATCHDIR}/${NAME}-2.2-alarm.patch.gz | patch -p1 -E --backup --verbose
# obsolete with version upgrade (AUDPLUG-159), but recheck that XMP's plugin
# no longer manages to insert non-URI filenames into the playlist
zcat ${SB_PATCHDIR}/${NAME}-2.2-xspf-base.patch.gz | patch -p1 -E --backup --verbose
# merged upstream (AUDPLUG-160)
zcat ${SB_PATCHDIR}/${NAME}-2.2-svis_expose.patch.gz | patch -p1 -E --backup --verbose
#
zcat ${SB_PATCHDIR}/${NAME}-2.2-neon-session-destroy.patch.gz | patch -p1 -E --backup --verbose
# obsolete with version upgrade
zcat ${SB_PATCHDIR}/${NAME}-2.2-adplug-fclose.patch.gz | patch -p1 -E --backup --verbose
#
zcat ${SB_PATCHDIR}/${NAME}-2.2-adplug-lds.patch.gz | patch -p1 -E --backup --verbose
# reported upstream (AUDPLUG-180), as a rewrite of the plugin
# would be better
zcat ${SB_PATCHDIR}/${NAME}-2.2-streambrowser-race.patch.gz | patch -p1 -E --backup --verbose
# huh? AUDPLUG-161 / bz561635
# plus: hardcoded libdir replacement
# plus: fix dialogs (merged upstream)
zcat ${SB_PATCHDIR}/${NAME}-2.2-ladspa.patch.gz | patch -p1 -E --backup --verbose
# merged upstream (request destroy+NULL only, the important half)
zcat ${SB_PATCHDIR}/${NAME}-2.2-neon-error-handling.patch.gz | patch -p1 -E --backup --verbose
# revised version merged upstream
zcat ${SB_PATCHDIR}/${NAME}-2.2-tmp-vuln.patch.gz | patch -p1 -E --backup --verbose
#
zcat ${SB_PATCHDIR}/${NAME}-2.2-streambrowser-url-add.patch.gz | patch -p1 -E --backup --verbose
#
zcat ${SB_PATCHDIR}/${NAME}-2.2-scrobbler.patch.gz | patch -p1 -E --backup --verbose
# submitted upstream with add.patch for 2.3: AUDPLUG-170
zcat ${SB_PATCHDIR}/${NAME}-2.2-status.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
