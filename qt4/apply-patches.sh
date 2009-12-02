#!/bin/sh

set -e

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

# don't use -b on mkspec files, else they get installed too.
zcat ${SB_PATCHDIR}/qt-x11-opensource-src-4.2.2-multilib-optflags.patch.gz | patch -p1 -E --verbose

if [ "${_qt4_datadir}" != "${_qt4_prefix}" ] ;then
  zcat ${SB_PATCHDIR}/qt-x11-opensource-src-4.2.2-multilib-QMAKEPATH.patch.gz | patch -p1 -E --verbose
fi

zcat ${SB_PATCHDIR}/qt-all-opensource-src-4.4.0-rc1-as_IN-437440.patch.gz | patch -p1 -E --verbose

# hack around gcc/ppc crasher, http://bugzilla.redhat.com/492185
zcat ${SB_PATCHDIR}/qt-x11-opensource-src-4.5.0-gcc_hack.patch.gz | patch -p1 -E --verbose
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


## upstreamable bits
# http://bugzilla.redhat.com/485677
zcat ${SB_PATCHDIR}/qt-everywhere-opensource-src-4.6.0-beta1-qdoc3.patch.gz | patch -p1 -E --verbose
#zcat ${SB_PATCHDIR}/qt-4.5-sparc64.patch.gz | patch -p1 -E --verbose
# fix invalid inline assembly in qatomic_{i386,x86_64}.h (de)ref implementations
# should fix the reference counting in qt_toX11Pixmap and thus the Kolourpaint
# crash with Qt 4.5
zcat ${SB_PATCHDIR}/qt-x11-opensource-src-4.5.0-fix-qatomic-inline-asm.patch.gz | patch -p1 -E --verbose
# fix invalid assumptions about mysql_config --libs
# http://bugzilla.redhat.com/440673
zcat ${SB_PATCHDIR}/qt-x11-opensource-src-4.5.1-mysql_config.patch.gz | patch -p1 -E --verbose

# security patches

# kde-qt git patches
## older, but actually applies, version of patches 208, 209, 213 (double check)
#zcat ${SB_PATCHDIR}/0274-shm-native-image-fix.patch.gz | patch -p1 -E --verbose

( SB_PATCHDIR=patches
  # Ignore list, e.g: ="0003 0010"
  export IGNORE=""
  IgnorePatch ${SB_PATCHDIR}/list
  for patch in $(<${SB_PATCHDIR}/list) ;do
    ApplyPatch ${patch}
  done
)

set +e
