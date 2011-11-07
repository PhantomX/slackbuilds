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
ApplyPatch qt-x11-opensource-src-4.2.2-multilib-optflags.patch.gz
# get rid of timestamp which causes multilib problem
ApplyPatch qt-everywhere-opensource-src-4.7.0-beta1-uic_multilib.patch
# enable ft lcdfilter
ApplyPatch qt-x11-opensource-src-4.5.1-enable_ft_lcdfilter.patch.gz
# include kde4 plugin path, http://bugzilla.redhat.com/498809
#ApplyPatch qt-everywhere-opensource-src-4.7.0-beta2-kde4_plugins.patch 
ApplyPatch qt-everywhere-opensource-src-4.7.0-beta2-phonon_servicesfile.patch 

# may be upstreamable, not sure yet
# workaround for gdal/grass crashers wrt glib_eventloop null deref's
ApplyPatch qt-everywhere-opensource-src-4.6.3-glib_eventloop_nullcheck.patch
# remove dependency of webkit in assistant
#ApplyPatch qt-everywhere-opensource-src-4.7.1-assistant_no_webkit.patch.patch

## upstreamable bits
# fix invalid inline assembly in qatomic_{i386,x86_64}.h (de)ref implementations
# should fix the reference counting in qt_toX11Pixmap and thus the Kolourpaint
# crash with Qt 4.5
ApplyPatch qt-x11-opensource-src-4.5.0-fix-qatomic-inline-asm.patch.gz
# fix invalid assumptions about mysql_config --libs
# http://bugzilla.redhat.com/440673
ApplyPatch qt-everywhere-opensource-src-4.7.0-beta2-mysql_config.patch
# http://bugs.kde.org/show_bug.cgi?id=180051#c22
zcat ${SB_PATCHDIR}/qt-everywhere-opensource-src-4.6.2-cups.patch.gz
# qtwebkit to search nspluginwrapper paths too
ApplyPatch qt-everywhere-opensource-src-4.7.0-beta1-qtwebkit_pluginpath.patch
# indic incorrect rendering
ApplyPatch qt-4.6.3-bn-rendering-bz562049.patch
ApplyPatch qt-4.6.3-bn-rendering-bz562058.patch
ApplyPatch qt-4.6.3-indic-rendering-bz631732.patch
ApplyPatch qt-4.6.3-indic-rendering-bz636399.patch

# Fails to create debug build of Qt projects on mingw (rhbz#653674)
ApplyPatch qt-everywhere-opensource-src-4.7.1-QTBUG-14467.patch

# Qt doesn't close orphaned file descriptors after printing (#746601, QTBUG-14724)
ApplyPatch qt-everywhere-opensource-src-4.8.0-QTBUG-14724.patch

# workaround aliasing issues in declarative/qml (#748936, QTBUG-19736) 
ApplyPatch qt-everywhere-opensource-src-4.7.4-qml_no_strict_aliasing.patch

# workaround
# sql/drivers/tds/qsql_tds.cpp:341:49: warning: dereferencing type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]
ApplyPatch qt-everywhere-opensource-src-4.7.4-tds_no_strict_aliasing.patch

ApplyPatch qt-everywhere-opensource-src-4.6.1-add_missing_bold_style.patch.gz

# security patches
ApplyPatch qt-everywhere-opensource-src-4.7.0-CVE-2010-1822-crash-svg-image.patch

## upstream patches
# Applications crash when using a visual with 24 bits per pixel 
# https://bugreports.qt.nokia.com/browse/QTBUG-21754
ApplyPatch qt-everywhere-opensource-src-4.7.4-QTBUG-21754.patch
# adds debug support to webkit/JavaScriptCore
# UPSTREAM ME
ApplyPatch qt-everywhere-opensource-src-4.7.1-webkit_debug_javascriptcore.patch
# bz#705348, per-font autohint fontconfig directives globally disable the bytecode interpreter 
ApplyPatch QTBUG-19947-fontconfig-2.patch

# kde-qt patches
ApplyPatch 0004-0005.patch
ApplyPatch 0012-Add-context-to-tr-calls-in-QShortcut.patch
( SB_PATCHDIR=patches
  # Ignore list, e.g: ="0003 0010"
  export IGNORE="0004 0005"
  IgnorePatch ${SB_PATCHDIR}/list
  for patch in $(<${SB_PATCHDIR}/list) ;do
    ApplyPatch ${patch}
  done
)

set +e +o pipefail
