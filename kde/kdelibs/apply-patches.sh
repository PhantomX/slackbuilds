# The set of patches from hell :)

set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 --verbose --backup -i ${SB_PATCHDIR}/${NAME}.patch
# /usr/doc/HTML
patch -p1 --verbose --backup -z .htmldir -i ${SB_PATCHDIR}/kdelibs-4.9.0-htmldir.patch
# make -devel packages parallel-installable
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.5.80-parallel_devel.patch
# fix kde#149705
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.10.0-kde149705.patch
# install all .css files and Doxyfile.global in kdelibs-common to build
# kdepimlibs-apidocs against
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.3.90-install_all_css.patch

# Add "(Slackware)" to khtml user agent
sed -e "s|_KDELIBS_SLK_DIST|${KDELIBS_SLK_DIST}|g" \
  ${SB_PATCHDIR}/kdelibs-4.10.0-branding-slk.patch | patch -p1 -E --backup --verbose

# patch KStandardDirs to use /usr/libexec/kde4 instead of /usr/lib${LIBDIRSUFFIX}/kde4/libexec
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.11.3-libexecdir.patch
# kstandarddirs changes: search /etc/kde, find /usr/libexec/kde4
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.11.97-kstandarddirs.patch
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.10.0-cmake.patch

# die rpath die, since we're using standard paths, we can avoid
# this extra hassle (even though cmake is *supposed* to not add standard
# paths (like /usr/lib64) already! With this, we can drop
# -DCMAKE_SKIP_RPATH:BOOL=ON (finally)
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.10.0-no_rpath.patch

# reduce stderr spamming about invalid mimetypes (kWarning->kDebug)
# workaround for http://bugzilla.redhat.com/1184918
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.14.4-unknown_mimetype_spam.patch
# limit solid qDebug spam

# limit solid qDebug spam
# http://bugzilla.redhat.com/882731
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-solid_qt_no_debug_output.patch


# knewstuff2 variant of:
# https://git.reviewboard.kde.org/r/102439/
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.7.0-knewstuff2_gpg2.patch

# Toggle solid upnp support at runtime via env var SOLID_UPNP=1 (disabled by default)
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.10.0-SOLID_UPNP.patch

# return valid locale (RFC 1766)
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.8.4-kjs-locale.patch

# borrow from  opensuse
# https://build-test.opensuse.org/package/view_file/home:coolo:test/kdelibs4/0001-Drop-Nepomuk-from-KParts-LINK_INTERFACE_LIBRARIES.patch
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/Drop-Nepomuk-from-KParts-LINK_INTERFACE_LIBRARIES.patch

# candidate fix for: kde deamon crash on wakeup
# https://bugs.kde.org/show_bug.cgi?id=288410
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-kdebug288410.patch

# make filter working
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.9.3-kcm_ssl.patch

# disable dot to reduce apidoc size
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.12.90-dot.patch

# set QT_NO_GLIB in klauncher_main.cpp as a possible fix/workaround for #983110
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.11.3-klauncher-no-glib.patch

# opening a terminal in Konqueror / Dolphin does not inherit environment variables
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.13.2-invokeTerminal.patch

# Gentoo/Mandriva
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.6.3-no_suid_kdeinit.patch

# official backports

# Branch upstream
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/changeset_r5f957ebf94aa5a02815c5bf1e3f59060363efd77.diff
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/changeset_r2b5c6e42fc8114c6854ce490b9cdd4356be683d9.diff


# revert these commits for
#https://bugs.kde.org/315578
# for now, causes regression,
#https://bugs.kde.org/317138
patch -p1 -R --verbose --backup -i ${SB_PATCHDIR}/return-not-break.-copy-paste-error.patch
patch -p1 -R --verbose --backup -i ${SB_PATCHDIR}/coding-style-fixes.patch
patch -p1 -R --verbose --backup -i ${SB_PATCHDIR}/return-application-icons-properly.patch

# Trunk patches

set +e +o pipefail
