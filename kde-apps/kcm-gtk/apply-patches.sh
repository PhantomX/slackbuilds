  
SB_PATCHDIR=${CWD}/patches

## upstreamable patches
# Categories += Settings, else doesn't appear in systemsettings anywhere (?)
zcat ${SB_PATCHDIR}/${NAME}-0.5.1-settings_category.patch.gz | patch -p1 -E --backup --verbose || exit 1
# ensures GTK2_RC_FILES gets used/updated on first use, avoids 
# possible need for logout/login, code borrowed from kdebase-workspace's krdb.cpp
zcat ${SB_PATCHDIR}/${NAME}-0.5.3-gtkrc_setenv.patch.gz | patch -p1 -E --backup --verbose || exit 1
# fix missing umlauts and sharp s in the German translation
# The translations need a lot more fixing than that, but this looks very broken!
zcat ${SB_PATCHDIR}/${NAME}-0.5.3-fix-de.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Support to ~/.gtkrc-2.0.mine for extra settings
zcat ${SB_PATCHDIR}/${NAME}-0.5.3-add-dotmine.patch.gz | patch -p0 -E --backup --verbose || exit 1
