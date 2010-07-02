#!/bin/sh

set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

PATCHCOM="patch -p1 -F1 -s --verbose"

ApplyPatch() {
  local patch=$1
  shift
  if [ ! -f ${SB_PATCHDIR}/${patch} ]; then
    exit 1
  fi
  case "${patch}" in
  *.bz2) bzcat "${SB_PATCHDIR}/${patch}" | ${PATCHCOM} ${1+"$@"} ;;
  *.gz) zcat "${SB_PATCHDIR}/${patch}" | ${PATCHCOM} ${1+"$@"} ;;
  *) ${PATCHCOM} ${1+"$@"} -i "${SB_PATCHDIR}/${patch}" ;;
  esac
}

IgnorePatch() {
  if [ -n "{IGNORE}" ] ;then
    for patchnumber in ${IGNORE} ;do
      sed -e "/^${patchnumber}/d" -i $1
    done
  fi
}

# patch -p0 -E --backup --verbose ${SB_PATCHDIR}/${NAME}.patch
# don't use -b on mkspec files, else they get installed too.
zcat ${SB_PATCHDIR}/qt-x11-opensource-src-4.2.2-multilib-optflags.patch.gz | patch -p1 -E --verbose

if [ "${_qt4_datadir}" != "${_qt4_prefix}" ] ;then
  zcat ${SB_PATCHDIR}/qt-x11-opensource-src-4.2.2-multilib-QMAKEPATH.patch.gz | patch -p1 -E --verbose
fi

zcat ${SB_PATCHDIR}/qt-all-opensource-src-4.4.0-rc1-as_IN-437440.patch.gz | patch -p1 -E --verbose

# hack around gcc/ppc crasher, http://bugzilla.redhat.com/492185
#zcat ${SB_PATCHDIR}/qt-x11-opensource-src-4.5.0-gcc_hack.patch.gz | patch -p1 -E --verbose
zcat ${SB_PATCHDIR}/qt-x11-opensource-src-4.5.1-enable_ft_lcdfilter.patch.gz | patch -p1 -E --verbose
# include kde4 plugin path, http://bugzilla.redhat.com/498809
zcat ${SB_PATCHDIR}/qt-x11-opensource-src-4.5.1-kde4_plugins.patch.gz | patch -p1 -E --verbose

# make PulseAudio the default device in Phonon with the xine-lib backend
# (The GStreamer backend handles this entirely differently, with a separate
# "sink" setting, and should pick up the PulseAudio "sink" without patches.)
if [ "${SB_PA}" = "YES" ] ;then
  zcat ${SB_PATCHDIR}/qt-x11-opensource-src-4.5.2-pulseaudio.patch.gz | patch -p1 -E --verbose
  zcat ${SB_PATCHDIR}/qt-everywhere-opensource-src-4.6.0-gst-pulsaudio.patch.gz | patch -p1 -E --verbose
fi

zcat ${SB_PATCHDIR}/qt-x11-opensource-src-4.5.1-phonon.patch.gz | patch -p1 -E --verbose

# use system ca-bundle certs, http://bugzilla.redhat.com/521911
zcat ${SB_PATCHDIR}/qt-x11-opensource-src-4.5.3-system_ca_certificates.patch.gz | patch -p1 -E --verbose
# may be upstreamable, not sure yet
# workaround for gdal/grass crashers wrt glib_eventloop null deref's
ApplyPatch qt-everywhere-opensource-src-4.6.3-glib_eventloop_nullcheck.patch

## upstreamable bits
#zcat ${SB_PATCHDIR}/qt-4.5-sparc64.patch.gz | patch -p1 -E --verbose
# fix invalid inline assembly in qatomic_{i386,x86_64}.h (de)ref implementations
# should fix the reference counting in qt_toX11Pixmap and thus the Kolourpaint
# crash with Qt 4.5
zcat ${SB_PATCHDIR}/qt-x11-opensource-src-4.5.0-fix-qatomic-inline-asm.patch.gz | patch -p1 -E --verbose
# fix invalid assumptions about mysql_config --libs
# http://bugzilla.redhat.com/440673
zcat ${SB_PATCHDIR}/qt-x11-opensource-src-4.5.1-mysql_config.patch.gz | patch -p1 -E --verbose
# http://bugs.kde.org/show_bug.cgi?id=180051#c22
zcat ${SB_PATCHDIR}/qt-everywhere-opensource-src-4.6.2-cups.patch.gz

zcat ${SB_PATCHDIR}/qt-everywhere-opensource-src-4.6.0-fix-str-fmt.patch.gz | patch -p0 -E --verbose
zcat ${SB_PATCHDIR}/qt-everywhere-opensource-src-4.6.1-add_missing_bold_style.patch.gz | patch -p1 -E --verbose
zcat ${SB_PATCHDIR}/qt-everywhere-opensource-src-4.6.1-use_ft_glyph_embolden_to_fake_bold.patch.gz | patch -p1 -E --verbose


# security patches
# https://bugs.webkit.org/show_bug.cgi?id=40567
ApplyPatch qt-everywhere-opensource-src-4.7.0-beta1-qtwebkit_gtk_init.patch
ApplyPatch qt-everywhere-opensource-src-4.6.2-cve-2010-0051-lax-css-parsing-cross-domain-theft.patch
ApplyPatch qt-everywhere-opensource-src-4.6.2-cve-2010-0656.patch
ApplyPatch qt-everywhere-opensource-src-4.6.2-cve-2010-0648.patch
ApplyPatch qt-everywhere-opensource-src-4.6.3-CVE-2010-1303_1304.patch
ApplyPatch qt-everywhere-opensource-src-4.6.3-CVE-2010-1392.patch
ApplyPatch qt-everywhere-opensource-src-4.6.3-CVE-2010-1396.patch
ApplyPatch qt-everywhere-opensource-src-4.6.3-CVE-2010-1397.patch
ApplyPatch qt-everywhere-opensource-src-4.6.3-CVE-2010-1398.patch
ApplyPatch qt-everywhere-opensource-src-4.6.3-CVE-2010-1400.patch
ApplyPatch qt-everywhere-opensource-src-4.6.3-CVE-2010-1412.patch
ApplyPatch qt-everywhere-opensource-src-4.6.3-CVE-2010-1770.patch
ApplyPatch qt-everywhere-opensource-src-4.6.3-CVE-2010-1773.patch
ApplyPatch qt-everywhere-opensource-src-4.6.3-CVE-2010-1774.patch
ApplyPatch qt-everywhere-opensource-src-4.6.3-CVE-2010-1119.patch
ApplyPatch qt-everywhere-opensource-src-4.6.3-CVE-2010-1778.patch

ApplyPatch 0012-Add-context-to-tr-calls-in-QShortcut.patch
# QTBUG-9793
ApplyPatch 0ebc9783d8ca0c4b27208bbc002c53c52c19ab4c.patch

# kde-qt patches
( SB_PATCHDIR=patches
  # Ignore list, e.g: ="0003 0010"
  export IGNORE="0009"
  IgnorePatch ${SB_PATCHDIR}/list
  for patch in $(<${SB_PATCHDIR}/list) ;do
    ApplyPatch ${patch}
  done
)

set +e +o pipefail
