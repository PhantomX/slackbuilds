
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gdm-2.20.11-dso.patch

zcat ${SB_PATCHDIR}/gdm-2.20.10-xsession.patch.gz | patch -p0 -E --backup --verbose

zcat ${SB_PATCHDIR}/gdm-2.13.0.4-update-switchdesk-location.patch.gz | patch -p1 -E --backup --verbose

# http://bugzilla.gnome.org/show_bug.cgi?id=347798
zcat ${SB_PATCHDIR}/gdm-2.19.3-move-default-message.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/gdm-2.19.5-reset-pam.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/gdm-2.19.1-security-tokens.patch.gz | patch -p1 -E --backup --verbose

# https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=203917
zcat ${SB_PATCHDIR}/gdm-2.16.0-indic-langs.patch.gz | patch -p1 -E --backup --verbose

zcat ${SB_PATCHDIR}/gdm-2.17.1-desensitize-entry.patch.gz | patch -p1 -E --backup --verbose

# http://bugzilla.gnome.org/show_bug.cgi?id=411427
zcat ${SB_PATCHDIR}/gdm-2.17.7-greeter.patch.gz | patch -p0 -E --backup --verbose

# http://bugzilla.gnome.org/show_bug.cgi?id=412576
zcat ${SB_PATCHDIR}/gdm-2.19.1-a11y-fixes-for-themed-greeter.patch.gz | patch -p1 -E --backup --verbose

# http://bugzilla.gnome.org/show_bug.cgi?id=411501
zcat ${SB_PATCHDIR}/gdm-2.19.6-pass-ats-to-session.patch.gz | patch -p1 -E --backup --verbose

# make gdmsetup work with consolehelper
zcat ${SB_PATCHDIR}/gdmsetup-path.patch.gz | patch -p1 -E --backup --verbose

# http://bugzilla.gnome.org/show_bug.cgi?id=482348
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pixbuf-ref.patch

# http://bugzilla.redhat.com/show_bug.cgi?id=246399
zcat ${SB_PATCHDIR}/gdm-2.20.1-keymouselistener-segfault.patch.gz | patch -p1 -E --backup --verbose

# https://bugzilla.redhat.com/show_bug.cgi?id=383051
zcat ${SB_PATCHDIR}/gdm-2.20.3-cap-user-list-length.patch.gz | patch -p1 -E --backup --verbose

# https://bugzilla.redhat.com/show_bug.cgi?id=452567
zcat ${SB_PATCHDIR}/gdm-2.20.5-fix-non-utf8.patch.gz | patch -p1 -E --backup --verbose

zcat ${SB_PATCHDIR}/gdm-2.20.2-change-defaults.patch.gz | patch -p1 -E --backup --verbose

zcat ${SB_PATCHDIR}/stupid-bullets.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
