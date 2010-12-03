# The set of patches from hell :)

set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 --verbose --backup -i ${SB_PATCHDIR}/${NAME}.patch 
# make -devel packages parallel-installable
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.4.85-parallel_devel.patch
# fix kde#149705
zcat ${SB_PATCHDIR}/kdelibs-4.2.85-kde149705.patch.gz | patch -p1 --verbose --backup --suffix=.orig
# install all .css files and Doxyfile.global in kdelibs-common to build
# kdepimlibs-apidocs against
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.3.90-install_all_css.patch

# Add "(Slackware)" to khtml user agent
zcat ${SB_PATCHDIR}/kdelibs-4.0.2-branding-slk.patch.gz |sed \
  -e "s|_KDELIBS_SLK_DIST|${KDELIBS_SLK_DIST}|g" | patch -p1 -E --backup --verbose

# workaround for policykit
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.4.80-policykit-workaround.patch
#zcat ${SB_PATCHDIR}/kdelibs-4.1.0-xdg-menu.patch.gz | patch -p1 --verbose --backup --suffix=.orig
# patch KStandardDirs to use /usr/libexec/kde4 instead of /usr/lib${LIBDIRSUFFIX}/kde4/libexec
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.4.80-libexecdir.patch
# kstandarddirs changes: search /etc/kde, find /usr/libexec/kde4
zcat ${SB_PATCHDIR}/kdelibs-4.1.72-kstandarddirs.patch.gz | patch -p1 --verbose --backup --suffix=.orig
zcat ${SB_PATCHDIR}/kdelibs-4.1.70-cmake.patch.gz | patch -p1 --verbose --backup --suffix=.orig
#zcat ${SB_PATCHDIR}/kdelibs-4.3.1-drkonq.patch.gz | patch -p1 --verbose --backup --suffix=.orig

# die rpath die, since we're using standard paths, we can avoid
# this extra hassle (even though cmake is *supposed* to not add standard
# paths (like /usr/lib64) already! With this, we can drop
# -DCMAKE_SKIP_RPATH:BOOL=ON (finally)
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.4.80-no_rpath.patch

# add gpg2 support to knewstuff, rough first try s/gpg/gpg2/
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.5.1-knewstuff_gpg2.patch

# Mandriva

# official backports

# Branch upstream

# Trunk patches
# http://websvn.kde.org/?view=revision&revision=1185912
patch -p3 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.5.2-plasma_wallpaper_configchanged.patch

# security fix
## Not Upstreamed? why not ? -- Rex
zcat ${SB_PATCHDIR}/kdelibs-4.3.1-CVE-2009-2702.patch.gz | patch -p1 --verbose --backup --suffix=.orig

set +e +o pipefail
