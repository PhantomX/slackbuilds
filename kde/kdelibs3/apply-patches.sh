
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/kdelibs-utempter.diff.gz | patch -p1 --verbose --backup --suffix=.orig

# Set .kde3 as home dir
patch -p1 --verbose --backup -z .kde3dirs -i ${SB_PATCHDIR}/kdelibs-3.5.10-kde3-standarddirs.patch

# Fedora patches
zcat ${SB_PATCHDIR}/kdelibs-3.0.0-ndebug.patch.gz | patch -p1 --verbose --backup --suffix=.orig
zcat ${SB_PATCHDIR}/kdelibs-3.0.4-ksyscoca.patch.gz | patch -p1 --verbose --backup --suffix=.orig
zcat ${SB_PATCHDIR}/kdelibs-3.5.10-openssl.patch.gz | patch -p1 --verbose --backup --suffix=.orig
zcat ${SB_PATCHDIR}/kdelibs-3.4.91-buildroot.patch.gz | patch -p1 --verbose --backup --suffix=.orig
zcat ${SB_PATCHDIR}/kdelibs-3.2.3-cups.patch.gz | patch -p1 --verbose --backup --suffix=.orig
#zcat ${SB_PATCHDIR}/kdelibs-3.4.0-qtdoc.patch.gz | patch -p1 --verbose --backup --suffix=.orig
zcat ${SB_PATCHDIR}/kdelibs-3.4.92-inttype.patch.gz | patch -p1 --verbose --backup --suffix=.orig
zcat ${SB_PATCHDIR}/kdelibs-3.5.2-kdebug-kmail-quiet.patch.gz | patch -p1 --verbose --backup --suffix=.orig
zcat ${SB_PATCHDIR}/kdelibs-3.5.2-cupsdconf2-group.patch.gz | patch -p1 --verbose --backup --suffix=.orig
zcat ${SB_PATCHDIR}/kdelibs-3.5.4-kabc-make.patch.gz | patch -p1 --verbose --backup --suffix=.orig
zcat ${SB_PATCHDIR}/kdelibs-3.5.4-kdeprint-utf8.patch.gz | patch -p1 --verbose --backup --suffix=.orig
zcat ${SB_PATCHDIR}/kdelibs-3.5.6-lang.patch.gz | patch -p1 --verbose --backup --suffix=.orig
zcat ${SB_PATCHDIR}/kdelibs-3.5.8-kate-vhdl.patch.gz | patch -p1 --verbose --backup --suffix=.orig
if [ "${SB_HUNSPELL}" = "YES" ] ;then
  zcat ${SB_PATCHDIR}/kdelibs-3.5.8-kspell-hunspell.patch.gz | patch -p1 --verbose --backup --suffix=.orig
  zcat ${SB_PATCHDIR}/kdelibs-3.5.8-kspell2-enchant.patch.gz | patch -p1 --verbose --backup --suffix=.orig
  zcat ${SB_PATCHDIR}/kdelibs-3.5.8-kspell2-no-ispell.patch.gz | patch -p1 --verbose --backup --suffix=.orig
fi
zcat ${SB_PATCHDIR}/kdelibs-3.5.9-cupsserverbin.patch.gz | patch -p1 --verbose --backup --suffix=.orig
zcat ${SB_PATCHDIR}/kdelibs-3.5.9-KDE3.patch.gz | patch -p1 --verbose --backup --suffix=.orig
#fix flock and flock64 redefinition in newer kernels
zcat ${SB_PATCHDIR}/kdelibs-3.5.9-fix-flock-redefinition.patch.gz | patch -p1 --verbose --backup --suffix=.orig
# update the KatePart latex.xml syntax definition to the version from Kile 2.0.3
zcat ${SB_PATCHDIR}/kdelibs-3.5.10-latex-syntax-kile-2.0.3.patch.gz | patch -p1 --verbose --backup --suffix=.orig
# fix ftbfs (#631195)
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-3.5.10-qcolor_gcc_ftbfs.patch
# fix FTBFS (cups-util.c must include stdio.h, #714133)
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-3.5.10-cups-util-missing-header.patch
# fix FTBFS with CUPS 2.0 due to bad CUPS_VERSION_MAJOR checks
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-3.5.10-cups20.patch

# use /etc/kde in addition to /usr/share/config, borrowed from debian
zcat ${SB_PATCHDIR}/kdelibs-3.5.5-kstandarddirs.patch.gz | patch -p1 --verbose --backup --suffix=.orig
# http://bugs.kde.org/93359, alternative to export libltdl_cv_shlibext=".so" hack.
zcat ${SB_PATCHDIR}/kde-3.5-libtool-shlibext.patch.gz | patch -p1 --verbose --backup --suffix=.orig

zcat ${SB_PATCHDIR}/kdelibs-3.5.10-gcc44.patch.gz | patch -p1 --verbose --backup --suffix=.orig
patch -p4 --verbose --backup --suffix=.orig -i ${SB_PATCHDIR}/kdelibs-3.5.10-gcc45.patch
patch -p1 --verbose --backup --suffix=.orig -i ${SB_PATCHDIR}/kdelibs-3.5.10-ossl-1.x.patch
zcat ${SB_PATCHDIR}/kdelibs-3.5.10-kio.patch.gz | patch -p1 --verbose --backup --suffix=.orig
zcat ${SB_PATCHDIR}/kdelibs-3.5.10-assert.patch.gz | patch -p1 --verbose --backup --suffix=.orig
zcat ${SB_PATCHDIR}/kdelibs-3.5.10-dtoa.patch.gz | patch -p1 --verbose --backup --suffix=.orig
zcat ${SB_PATCHDIR}/kdelibs-3.5.10-kabc.patch.gz | patch -p1 --verbose --backup --suffix=.orig
patch -p4 --verbose --backup --suffix=.orig -i ${SB_PATCHDIR}/kdelibs-3.5.10-kdebug-timestamp.patch
patch -p4 --verbose --backup --suffix=.orig -i ${SB_PATCHDIR}/kdelibs-3.5.10-kmenubar-struct.patch
# kde4.4 backport
patch -p1 --verbose --backup --suffix=.orig -i ${SB_PATCHDIR}/kdelibs-3.5.10-kde-config_kde-version.patch
# cups 1.6 patch adapted from Trinity Desktop
patch -p1 --verbose --backup -z .cups16 -i ${SB_PATCHDIR}/kdelibs-3.5.10-cups16.patch

# security fixes
## security fixes
# fix CVE-2009-2537 - select length DoS
zcat ${SB_PATCHDIR}/kdelibs-3.5.10-cve-2009-2537-select-length.patch.gz | patch -p1 --verbose --backup --suffix=.orig
# fix CVE-2009-1725 - crash, possible ACE in numeric character references
zcat ${SB_PATCHDIR}/kdelibs-3.5.10-cve-2009-1725.patch.gz | patch -p0 --verbose --backup --suffix=.orig
# fix CVE-2009-1690 - crash, possible ACE in KHTML (<head> use-after-free)
zcat ${SB_PATCHDIR}/kdelibs-3.5.4-CVE-2009-1687.patch.gz | patch -p1 --verbose --backup --suffix=.orig
# fix CVE-2009-1687 - possible ACE in KJS (FIXME: still crashes?)
zcat ${SB_PATCHDIR}/kdelibs-3.5.4-CVE-2009-1690.patch.gz | patch -p1 --verbose --backup --suffix=.orig
# fix CVE-2009-1698 - crash, possible ACE in CSS style attribute handling
zcat ${SB_PATCHDIR}/kdelibs-3.5.10-cve-2009-1698.patch.gz | patch -p1 --verbose --backup --suffix=.orig
# fix CVE-2009-2702 - ssl incorrect verification of SSL certificate with NUL in subjectAltName
zcat ${SB_PATCHDIR}/kdelibs-3.5.10-CVE-2009-2702.patch.gz | patch -p1 --verbose --backup --suffix=.orig
# fix oCERT-2009-015 - unrestricted XMLHttpRequest access to local URLs
zcat ${SB_PATCHDIR}/kdelibs-3.5.10-oCERT-2009-015-xmlhttprequest.patch.gz | patch -p0 --verbose --backup --suffix=.orig
# CVE-2009-3736, libltdl may load and execute code from a library in the current directory
zcat ${SB_PATCHDIR}/libltdl-CVE-2009-3736.patch.gz | patch -p1 --verbose --backup --suffix=.orig
# CVE-2011-3365, input validation failure in KSSL
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-3.5.x-CVE-2011-3365.patch
# CVE-2013-2074, prints passwords contained in HTTP URLs in error messages
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-3.5.10-CVE-2013-2074.patch

# tweak autoconfigury so that it builds with autoconf 2.64 or 2.65
zcat ${SB_PATCHDIR}/kde3-acinclude.patch.gz | patch -p1 --verbose --backup --suffix=.orig
# remove flawed and obsolete automake version check in admin/cvs.sh
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kde3-automake-version.patch
# fix build failure with automake 1.13: add the --add-missing flag
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kde3-automake-add-missing.patch

# Add "(Slackware)" to khtml user agent (modified from Gentoo patch).
zcat ${SB_PATCHDIR}/kdelibs-3.5-cattlebrand.patch.gz |sed \
  -e "s|_KDELIBS_SLK_DIST|${KDELIBS_SLK_DIST}|g" | patch -p0 -E --backup --verbose

zcat ${SB_PATCHDIR}/kicker-crash.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/inotify.patch.gz | patch -p0 -E --backup --verbose

zcat ${SB_PATCHDIR}/fix-async_configfile.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/fix-gmail_html_elemtimpl.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/fix-kwallet.patch.gz | patch -p1 -E --backup --verbose

# KDEmod patches
# Bugging iconview.
#zcat ${SB_PATCHDIR}/02-kip_rounded_selection_box.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/03-kip_rubberband.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/04-execute_feedback.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/11-xinerama.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/12-kspell_spellcheck_default_utf8.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/13-konqueror_textcompletion_editor.patch.gz | patch -p1 -E --backup --verbose

# Mandriva patches
zcat ${SB_PATCHDIR}/kdelibs-3.5.10-glibc-inotify.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/kdelibs-3.5.3-fix-enable-dialogbox.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/kdelibs-3.5.4-dcop_wrong_reply.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/kdelibs-3.5.8-add-bookmark-dialog.patch.gz | patch -p0 -E --backup --verbose
#zcat ${SB_PATCHDIR}/kdelibs-3.5.8-lzma_support.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/kdelibs-3.5.9-kio-kfile-grouplist.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
