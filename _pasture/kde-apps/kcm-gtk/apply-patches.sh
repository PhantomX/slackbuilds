
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## upstreamable patches
# Categories += Settings, else doesn't appear in systemsettings anywhere (?)
zcat ${SB_PATCHDIR}/${NAME}-0.5.1-settings_category.patch.gz | patch -p1 -E --backup --verbose
# ensures GTK2_RC_FILES gets used/updated on first use, avoids 
# possible need for logout/login, code borrowed from kdebase-workspace's krdb.cpp
zcat ${SB_PATCHDIR}/${NAME}-0.5.3-gtkrc_setenv.patch.gz | patch -p1 -E --backup --verbose
# fix missing umlauts and sharp s in the German translation
# The translations need a lot more fixing than that, but this looks very broken!
zcat ${SB_PATCHDIR}/${NAME}-0.5.3-fix-de.patch.gz | patch -p1 -E --backup --verbose
# https://bugs.launchpad.net/kcm-gtk/+bug/505988, already upstream
# Modified so that it applies over the setenv patch, and removed index.theme
# existence check: https://bugs.launchpad.net/kcm-gtk/+bug/505988/comments/4
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.5.3-cursortheme.patch

# Support to ~/.gtkrc-2.0.mine for extra settings
patch -p0 -E --backup -z .mine --verbose -i ${SB_PATCHDIR}/${NAME}-0.5.3-add-dotmine.patch

set +e +o pipefail
