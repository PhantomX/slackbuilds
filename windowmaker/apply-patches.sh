
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${PNAME}-0.92.0-cvs20060123.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${PNAME}-gcc41.patch.gz | patch -p0 -E --backup --verbose
#patches from altlinux
zcat ${SB_PATCHDIR}/${PNAME}-0.91.0-alt-sowings.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${PNAME}-0.91.0-alt-session.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${PNAME}-0.91.0-alt-restartscrpt.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${PNAME}-0.91.0-alt-menutrans.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${PNAME}-0.91.0-alt-titlebar.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${PNAME}-0.91.0-alt-clipnotext.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${PNAME}-0.91.0-alt-mmx.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${PNAME}-0.80.2-cvs-alt-textfield.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${PNAME}-0.91.0-alt-focus.patch.gz | patch -p1 -E --backup --verbose

#add new features as well (sound good)
zcat ${SB_PATCHDIR}/${PNAME}-0.91.0-wmcontrib-singleclick.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${PNAME}-0.91.0-alt-dockhotkeys.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${PNAME}-0.91.0-alt-vlaad-trance.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${PNAME}-0.91.0-alt-vlaad-newbuttons.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${PNAME}-0.91.0-alt-adialog.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${PNAME}-0.91.0-hmepas-minimizeall.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${PNAME}-0.91.0-hmepas-swmenu_rclick.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${PNAME}-0.91.0-sga-moving-add.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${PNAME}-0.91.0-peter-newappicon.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${PNAME}-0.91.0-peter-mouse-placement.patch.gz | patch -p1 -E --backup --verbose
# actually a fixed version that does respect animations of settings
# for the bounce animation. Fixes #185579.
zcat ${SB_PATCHDIR}/${PNAME}-0.91.0-peter-appicon-bouncer2.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${PNAME}-0.91.0-sga-swpanel-customization.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${PNAME}-0.92.0-alt-newpo.patch.gz | patch -p1 -E --backup --verbose

# wakeup enhancements to save power (#267041)
zcat ${SB_PATCHDIR}/${PNAME}-wakeup-dnotify.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${PNAME}-wakeup-delayedAction.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${PNAME}-wakeup-timer.patch.gz | patch -p1 -E --backup --verbose

zcat ${SB_PATCHDIR}/WindowMaker-0.92.0-png14.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
