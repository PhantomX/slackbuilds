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
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.9.97-libexecdir.patch
# kstandarddirs changes: search /etc/kde, find /usr/libexec/kde4
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.10.0-kstandarddirs.patch
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.10.0-cmake.patch

# die rpath die, since we're using standard paths, we can avoid
# this extra hassle (even though cmake is *supposed* to not add standard
# paths (like /usr/lib64) already! With this, we can drop
# -DCMAKE_SKIP_RPATH:BOOL=ON (finally)
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.10.0-no_rpath.patch

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

# patch FindSamba.cmake to find samba4 libs (using pkg-config hints)
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.9.90-FindSamba_samba4.patch

# make filter working
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.9.3-kcm_ssl.patch

# disable dot to reduce apidoc size
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.9.3-dot.patch

# Gentoo/Mandriva
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.6.3-no_suid_kdeinit.patch

# official backports

# Branch upstream
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/changeset_rd81b00e9a0f67ac992df1034d920477b5f8b7c1c.diff
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/changeset_r326106bf5b928e7d88540e3643ab4ede7e412413.diff
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/changeset_r8d4f958586ab29bcfa9c70bb919540839c9bd2ac.diff
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/changeset_rb51b9ba8bfa38fd3d12437f8b183acf7d7ea143b.diff
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/changeset_r1f6d6cfc44a909a972b974fe4b79c0ef521ddd14.diff
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/changeset_r1576fd4df15b9cced4920b7ce0f49b467c5c081c.diff

# Trunk patches

# security fix
## Not Upstreamed? why not ? -- Rex
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.10.0-CVE-2009-2702.patch

set +e +o pipefail
