
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-2.13.0.4-update-switchdesk-location.patch.gz | patch -p1 -E --backup --verbose || exit 1

# http://bugzilla.gnome.org/show_bug.cgi?id=347798
zcat ${SB_PATCHDIR}/${NAME}-2.19.3-move-default-message.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.19.5-reset-pam.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.19.1-security-tokens.patch.gz | patch -p1 -E --backup --verbose || exit 1

# https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=203917
zcat ${SB_PATCHDIR}/${NAME}-2.16.0-indic-langs.patch.gz | patch -p1 -E --backup --verbose || exit 1

zcat ${SB_PATCHDIR}/${NAME}-2.17.1-desensitize-entry.patch.gz | patch -p1 -E --backup --verbose || exit 1

# http://bugzilla.gnome.org/show_bug.cgi?id=411427
zcat ${SB_PATCHDIR}/${NAME}-2.17.7-greeter.patch.gz | patch -p0 -E --backup --verbose || exit 1

# http://bugzilla.gnome.org/show_bug.cgi?id=412576
zcat ${SB_PATCHDIR}/${NAME}-2.19.1-a11y-fixes-for-themed-greeter.patch.gz | patch -p1 -E --backup --verbose || exit 1

# http://bugzilla.gnome.org/show_bug.cgi?id=411501
zcat ${SB_PATCHDIR}/${NAME}-2.19.6-pass-ats-to-session.patch.gz | patch -p1 -E --backup --verbose || exit 1

# make gdmsetup work with consolehelper
zcat ${SB_PATCHDIR}/${NAME}setup-path.patch.gz | patch -p1 -E --backup --verbose || exit 1

# https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=254164
zcat ${SB_PATCHDIR}/${NAME}-2.19.8-selinux.patch.gz | patch -p1 -E --backup --verbose || exit 1

# http://bugzilla.gnome.org/show_bug.cgi?id=482348
zcat ${SB_PATCHDIR}/pixbuf-ref.patch.gz | patch -p1 -E --backup --verbose || exit 1

# http://bugzilla.redhat.com/show_bug.cgi?id=246399
zcat ${SB_PATCHDIR}/${NAME}-2.20.1-keymouselistener-segfault.patch.gz | patch -p1 -E --backup --verbose || exit 1

# hack around broken tcp wrappers support
# FIXME need to file upstream and get fixed in 2.20
zcat ${SB_PATCHDIR}/${NAME}-2.18.4-tcp-wrappers.patch.gz | patch -p1 -E --backup --verbose || exit 1

# https://bugzilla.redhat.com/show_bug.cgi?id=383051
zcat ${SB_PATCHDIR}/${NAME}-2.20.3-cap-user-list-length.patch.gz | patch -p1 -E --backup --verbose || exit 1

zcat ${SB_PATCHDIR}/${NAME}-2.20.2-change-defaults.patch.gz | patch -p1 -E --backup --verbose || exit 1
