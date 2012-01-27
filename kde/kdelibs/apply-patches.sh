# The set of patches from hell :)

set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 --verbose --backup -i ${SB_PATCHDIR}/${NAME}.patch 
# make -devel packages parallel-installable
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.5.80-parallel_devel.patch
# fix kde#149705
zcat ${SB_PATCHDIR}/kdelibs-4.2.85-kde149705.patch.gz | patch -p1 --verbose --backup --suffix=.orig
# install all .css files and Doxyfile.global in kdelibs-common to build
# kdepimlibs-apidocs against
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.3.90-install_all_css.patch

# Add "(Slackware)" to khtml user agent
sed -e "s|_KDELIBS_SLK_DIST|${KDELIBS_SLK_DIST}|g" \
  ${SB_PATCHDIR}/kdelibs-4.6.80-branding-slk.patch | patch -p1 -E --backup --verbose

# patch KStandardDirs to use /usr/libexec/kde4 instead of /usr/lib${LIBDIRSUFFIX}/kde4/libexec
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.8.0-libexecdir.patch
# kstandarddirs changes: search /etc/kde, find /usr/libexec/kde4
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.6.90-kstandarddirs.patch
zcat ${SB_PATCHDIR}/kdelibs-4.1.70-cmake.patch.gz | patch -p1 --verbose --backup --suffix=.orig

# die rpath die, since we're using standard paths, we can avoid
# this extra hassle (even though cmake is *supposed* to not add standard
# paths (like /usr/lib64) already! With this, we can drop
# -DCMAKE_SKIP_RPATH:BOOL=ON (finally)
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.5.80-no_rpath.patch

# knewstuff2 variant of:
# https://git.reviewboard.kde.org/r/102439/
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.7.0-knewstuff2_gpg2.patch

# https://bugs.kde.org/show_bug.cgi?id=269045
# https://git.reviewboard.kde.org/r/101231/
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.6.2-uri_mimetypes.patch

# Toggle solid upnp support at runtime via env var SOLID_UPNP=1 (disabled by default)
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.7.4-SOLID_UPNP.patch

# make forcefully hal-free build
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.7.3-halectomy.patch

# Gentoo/Mandriva
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.6.3-no_suid_kdeinit.patch

# official backports

# Branch upstream

# Trunk patches

# security fix
## Not Upstreamed? why not ? -- Rex
zcat ${SB_PATCHDIR}/kdelibs-4.3.1-CVE-2009-2702.patch.gz | patch -p1 --verbose --backup --suffix=.orig
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.7.3-CVE-0046.patch

set +e +o pipefail
