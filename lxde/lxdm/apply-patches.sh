
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# http://lxde.git.sourceforge.net/git/gitweb.cgi?p=lxde/lxdm;a=commit;h=19f82a20
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lxdm-0.4.1-null-pointer.patch
# http://lxde.git.sourceforge.net/git/gitweb.cgi?p=lxde/lxdm;a=commit;h=bed2fed7
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lxdm-0.4.1-missing-semicolons.patch
# http://lxde.git.sourceforge.net/git/gitweb.cgi?p=lxde/lxdm;a=commit;h=14b6c103
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lxdm-0.4.1-spelling-mistake.patch
# https://bugzilla.redhat.com/show_bug.cgi?id=794478
# http://lxde.git.sourceforge.net/git/gitweb.cgi?p=lxde/lxdm;a=commit;h=d4e41ecb
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lxdm-0.4.1-softlockup.patch
# http://lxde.git.sourceforge.net/git/gitweb.cgi?p=lxde/lxdm;a=commit;h=13a92c1d
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lxdm-0.4.1-tcp-listen.patch
# http://lxde.git.sourceforge.net/git/gitweb.cgi?p=lxde/lxdm;a=commit;h=f11ae65e
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lxdm-0.4.1-exec-dbus.patch
# https://bugzilla.redhat.com/show_bug.cgi?id=635897
# http://lxde.git.sourceforge.net/git/gitweb.cgi?p=lxde/lxdm;a=commit;h=a8db292c
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lxdm-0.4.1-xauth.patch
# http://lxde.git.sourceforge.net/git/gitweb.cgi?p=lxde/lxdm;a=commit;h=9dc81f33
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lxdm-0.4.1-no-password.patch
# https://bugzilla.redhat.com/show_bug.cgi?id=758484
# http://lxde.git.sourceforge.net/git/gitweb.cgi?p=lxde/lxdm;a=commit;h=bd278369
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lxdm-0.4.1-GDK_KEY_Escape.patch
# http://lxde.git.sourceforge.net/git/gitweb.cgi?p=lxde/lxdm;a=commit;h=0c6d56ba
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lxdm-0.4.1-LXSESSION-variable.patch
# http://lxde.git.sourceforge.net/git/gitweb.cgi?p=lxde/lxdm;a=commit;h=d3a85803
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lxdm-0.4.1-old-plymouth.patch
# http://lxde.git.sourceforge.net/git/gitweb.cgi?p=lxde/lxdm;a=patch;h=8c71ffc87
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lxdm-0.4.1-restart-xserver-on-logout.patch

## Distro specific patches ##

# Distro artwork, start on vt1
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lxdm-0.4.1-config.patch

set +e +o pipefail
