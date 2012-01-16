
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# reinclude docs and translations
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-include-doc-po.patch
# fix desktop file permission
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-fix-perms.patch
# build fix against more recent glib2
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-buildfix-glib.patch
# default to using phonon (instead of mplayer)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.11.0a-kmplayerrc_phonon_default.patch
# http://websvn.kde.org/?view=revision&revision=1225583
# except the test lines are re-introduced
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-desktop_validate.patch

set +e +o pipefail
