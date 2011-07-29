
SB_PATCHDIR=${CWD}/patches

#zcat ${SB_PATCHDIR}/kdebase.startkde.xdg.diff.gz | patch -p1 --verbose --suffix=.orig --backup || exit 1
zcat ${SB_PATCHDIR}/kdebase-3.5.0_beta2-noimake.patch.gz | patch -p1 --verbose --suffix=.orig --backup || exit 1

zcat ${SB_PATCHDIR}/${NAME}-3.5.9-redhat-startkde.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Fedora patches
zcat ${SB_PATCHDIR}/${NAME}-3.4.2-kdesktop-konsole.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.5.1-kdm-readme.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.5.2-kconf_update-klipper.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.5.3-khelpcenter-sort.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.5.4-tango-icon-theme.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.5.4-konqueror-shortcut.patch.gz | patch -p1 -E --backup --verbose || exit 1
#zcat ${SB_PATCHDIR}/${NAME}-3.5.5-suspend.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.5.7-kio_media_mounthelper.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.5.10-konsolesu.patch.gz | patch -p1 -E --backup --verbose || exit 1

# fixes NTFS and adds PolicyKit support
zcat ${SB_PATCHDIR}/${NAME}-3.5.9-userdiskmount.patch.gz | patch -p1 -E --backup --verbose || exit 1

# don't link kcm_colors against libkrdb (and don't call runRdb)
zcat ${SB_PATCHDIR}/${NAME}-3.5.10-libkrd.gz | patch -p1 -E --backup --verbose || exit 1
# http://aseigo.blogspot.com/2008/10/dear-kde3-kdesktop-users.html
zcat ${SB_PATCHDIR}/${NAME}-3.5.10-minicli-decimal-comma.patch.gz | patch -p1 -E --backup --verbose || exit 1

# upstream patches

zcat ${SB_PATCHDIR}/fix-async_history.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-gcc44.patch.gz | patch -p1 -E --backup --verbose || exit 1

# KDEmod patches
zcat ${SB_PATCHDIR}/01-kip_rubberband.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/02-kip_kdesktop_rounded_icon_text_corners.patch.gz | patch -p1 -E --backup --verbose || exit 1
#zcat ${SB_PATCHDIR}/05-transparent_lock_logout_applet.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/06-systray_order.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/07-konqueror_textcompletion_editor.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/13-ksmserver_dont_save_compiz_session_ugly.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/16-xinerama.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/17-kdesktop_transparency_support.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/18-execute_feedback.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/19-kwin_shadow.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/20-ksmserver_theme_support.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/21-ksmserver_fade.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/22-add_change_session_icon.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/24-startkde_source_profile_directly.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/25-remove_white_border_around_images_in_kwebdesktop.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/27-konsole_url_handling.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Mandriva patches
zcat ${SB_PATCHDIR}/${NAME}-3.4.0-fix-scrnsaver.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.4.0-fix-vibrate-dialog.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.5.7-kdesktop_firstrun.patch.gz | patch -p1 -E --backup --verbose || exit 1
#zcat ${SB_PATCHDIR}/${NAME}-3.5.7-lzma_support.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.5.7-translation-override.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.5.8-ksmserver-timed.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.5.9-kdeject.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.5.9-kdesktop-crossfade.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.5.9-kdesktop-bg-nullImage.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.5.9-kdesktop-resize-bug.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.5.8-kmenu_tooltip_support.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.5.8-menu_icon_switch.patch.gz | patch -p1 -E --backup --verbose || exit 1
