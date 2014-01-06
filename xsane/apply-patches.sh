
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## Fedora
zcat ${SB_PATCHDIR}/${NAME}-0.995-xdg-open.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-0.995-close-fds.patch.gz | patch -p1 -E --backup --verbose
# https://bugzilla.redhat.com/show_bug.cgi?id=504344
# distro-specific, upstream won't accept it: "don't show license dialog"
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xsane-0.996-no-eula.patch
# submitted to upstream (Oliver Rauch) via email, 2010-06-23
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xsane-0.997-off-root-build.patch
# https://bugzilla.redhat.com/show_bug.cgi?id=608047
# submitted to upstream (Oliver Rauch) via email, 2010-07-13
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xsane-0.997-no-file-selected.patch
# https://bugzilla.redhat.com/show_bug.cgi?id=198422
# submitted to upstream (Oliver Rauch) via email, 2010-06-29
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xsane-0.997-ipv6.patch
# distro-specific: customize desktop file
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xsane-0.998-desktop-file.patch
# https://bugzilla.redhat.com/show_bug.cgi?id=693224
# submitted to upstream (Oliver Rauch) via email, 2011-04-04
####patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xsane-0.998-xsane_update_param-crash.patch
# https://bugzilla.redhat.com/show_bug.cgi?id=624190
# fix from: https://bugs.launchpad.net/ubuntu/+source/xsane/+bug/370818
# submitted to upstream (Oliver Rauch) via email, 2011-06-01
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xsane-0.998-preview-selection.patch
# fix building with libpng >= 1.5
# submitted to upstream (Oliver Rauch) via email, 2011-11-21
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xsane-0.998-libpng.patch
# https://bugzilla.redhat.com/show_bug.cgi?id=795085
# distro-specific: set program name/wmclass so GNOME shell picks appropriate
# high resolution icon file
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xsane-0.998-wmclass.patch
# man page: update command line options
# submitted to upstream (Oliver Rauch) via email, 2013-07-08
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xsane-0.999-man-page.patch
# avoid producing PDFs with bpp > 8
# submitted to upstream (Oliver Rauch) via email, 2013-09-09
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xsane-0.999-pdf-no-high-bpp.patch
# build against lcms 2.x
# submitted to upstream (Oliver Rauch) via email, 2013-09-23
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xsane-0.999-lcms2.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
