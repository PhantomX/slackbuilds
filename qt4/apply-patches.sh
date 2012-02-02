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
ApplyPatch qt-everywhere-opensource-src-4.8.0-tp-multilib-optflags.patch
# get rid of timestamp which causes multilib problem
ApplyPatch qt-everywhere-opensource-src-4.7.0-beta1-uic_multilib.patch
# enable ft lcdfilter
ApplyPatch qt-x11-opensource-src-4.5.1-enable_ft_lcdfilter.patch.gz
ApplyPatch qt-everywhere-opensource-src-4.7.0-beta2-phonon_servicesfile.patch 

# may be upstreamable, not sure yet
# workaround for gdal/grass crashers wrt glib_eventloop null deref's
ApplyPatch qt-everywhere-opensource-src-4.6.3-glib_eventloop_nullcheck.patch
# workaround for a MOC issue with Boost 1.48 headers (#756395)
ApplyPatch qt-everywhere-opensource-src-4.8.0-rc1-moc-boost148.patch

## upstreamable bits
# fix invalid inline assembly in qatomic_{i386,x86_64}.h (de)ref implementations
# should fix the reference counting in qt_toX11Pixmap and thus the Kolourpaint
# crash with Qt 4.5
ApplyPatch qt-x11-opensource-src-4.5.0-fix-qatomic-inline-asm.patch.gz
# fix invalid assumptions about mysql_config --libs
# http://bugzilla.redhat.com/440673
ApplyPatch qt-everywhere-opensource-src-4.7.0-beta2-mysql_config.patch
# http://bugs.kde.org/show_bug.cgi?id=180051#c22
ApplyPatch qt-everywhere-opensource-src-4.6.2-cups.patch.gz

# qtwebkit to search nspluginwrapper paths too
ApplyPatch qt-everywhere-opensource-src-4.7.0-beta1-qtwebkit_pluginpath.patch

# Fails to create debug build of Qt projects on mingw (rhbz#653674)
ApplyPatch qt-everywhere-opensource-src-4.7.1-QTBUG-14467.patch

# fix QTreeView crash triggered by KPackageKit (patch by David Faure)
ApplyPatch qt-everywhere-opensource-src-4.8.0-tp-qtreeview-kpackagekit-crash.patch

# https://bugs.webkit.org/show_bug.cgi?id=63941
# -Wall + -Werror = fail
( cd src/3rdparty/webkit
  ApplyPatch webkit-qtwebkit-2.2-no_Werror.patch
)

# revert qlist.h commit that seems to induce crashes in qDeleteAll<QList (QTBUG-22037)
ApplyPatch qt-everywhere-opensource-src-4.8.0-QTBUG-22037.patch

# Qt doesn't close orphaned file descriptors after printing (#746601, QTBUG-14724)
ApplyPatch qt-everywhere-opensource-src-4.8.0-QTBUG-14724.patch 

# Buttons in Qt applications not clickable when run under gnome-shell (#742658, QTBUG-21900)
ApplyPatch  qt-everywhere-opensource-src-4.8.0-QTBUG-21900.patch

# restore Qt-4.7 behavior (which kde needs) to QUrl.toLocalfile
# https://bugzilla.redhat.com/show_bug.cgi?id=749213
ApplyPatch qt-everywhere-opensource-src-4.8.0-QUrl_toLocalFile.patch

# workaround
# sql/drivers/tds/qsql_tds.cpp:341:49: warning: dereferencing type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]
ApplyPatch qt-everywhere-opensource-src-4.7.4-tds_no_strict_aliasing.patch
# don't spam if libicu is not present at runtime
ApplyPatch qt-everywhere-opensource-src-4.8.0-icu_no_spam.patch
# avoid dropping events, which lead to "ghost entries in kde task manager" problem
# https://bugs.kde.org/show_bug.cgi?id=275469
ApplyPatch qt-everywhere-opensource-src-4.8.0-filter_event.patch
# fix qvfb build
ApplyPatch qt-everywhere-opensource-src-4.8.0-qvfb.patch
# gcc doesn't support flag -fuse-ld=gold
ApplyPatch qt-everywhere-opensource-src-4.8.0-ld-gold.patch
# gcc-4.7 build issue
ApplyPatch qt-everywhere-opensource-src-4.8.0-gcc-4.7.patch

# security patches

## upstream patches
# adds debug support to webkit/JavaScriptCore
# UPSTREAM ME
ApplyPatch qt-everywhere-opensource-src-4.7.1-webkit_debug_javascriptcore.patch

set +e +o pipefail
