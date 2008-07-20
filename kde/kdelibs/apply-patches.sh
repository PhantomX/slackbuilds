# The set of patches from hell :)

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-utempter.diff.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1
#zcat ${SB_PATCHDIR}/${NAME}-kate-cursor-fix.diff.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1

zcat ${SB_PATCHDIR}/${NAME}-3.0.0-ndebug.patch.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.0.4-ksyscoca.patch.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.5.7-openssl.patch.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.4.91-buildroot.patch.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.2.3-cups.patch.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1
#zcat ${SB_PATCHDIR}/${NAME}-3.4.0-qtdoc.patch.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.4.92-inttype.patch.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.5.2-kdebug-kmail-quiet.patch.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.5.2-cupsdconf2-group.patch.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.5.4-kabc-make.patch.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.5.6-lang.patch.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.5.8-kate-vhdl.patch.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.5.9-cupsserverbin.patch.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1
# use /etc/kde in addition to /usr/share/config, borrowed from debian
zcat ${SB_PATCHDIR}/${NAME}-3.5.5-kstandarddirs.patch.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1
# http://bugs.kde.org/93359, alternative to export libltdl_cv_shlibext=".so" hack.
zcat ${SB_PATCHDIR}/kde-3.5-libtool-shlibext.patch.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1
# automake-1.10, $(all_libraries) is missing from a few LDFLAGS (kde #137675)
#zcat ${SB_PATCHDIR}/${NAME}-3.5.6-137675.patch.gz | patch -p0 --verbose --backup --suffix=.orig || exit 1

# Add "(Slackware)" to khtml user agent (modified from Gentoo patch).
zcat ${SB_PATCHDIR}/${NAME}-3.5-cattlebrand.patch.gz |sed \
  -e "s|_KDELIBS_SLK_DIST|${KDELIBS_SLK_DIST}|g" | patch -p0 -E --backup --verbose || exit 1

zcat ${SB_PATCHDIR}/${NAME}-3.5.8-kde\#150944.patch.gz | patch -p4 --verbose --backup --suffix=.orig || exit 1

zcat ${SB_PATCHDIR}/kicker-crash.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/inotify.patch.gz | patch -p0 -E --backup --verbose || exit 1
#zcat ${SB_PATCHDIR}/kconf-update-faster.diff.gz | patch -p0 -E --backup --verbose || exit 1

#http://www.kde.org/info/security/advisory-20080426-2.txt
#http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2008-1671
#zcat ${SB_PATCHDIR}/post-kde-3.5.5-kinit.diff.gz | patch -p0 -E --backup --verbose || exit 1

zcat ${SB_PATCHDIR}/branch-r805675.diff.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/fix-async_configfile.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/fix-gmail_html_elemtimpl.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/fix-kwallet.patch.gz | patch -p1 -E --backup --verbose || exit 1


# KDEmod patches
# Bugging iconview.
#zcat ${SB_PATCHDIR}/02-kip_rounded_selection_box.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/03-kip_rubberband.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/04-execute_feedback.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/11-xinerama.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/13-konqueror_textcompletion_editor.patch.gz | patch -p1 -E --backup --verbose || exit 1
