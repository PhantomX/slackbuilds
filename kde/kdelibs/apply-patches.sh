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
  ${SB_PATCHDIR}/kdelibs-4.5.80-branding-slk.patch | patch -p1 -E --backup --verbose

#zcat ${SB_PATCHDIR}/kdelibs-4.1.0-xdg-menu.patch.gz | patch -p1 --verbose --backup --suffix=.orig
# patch KStandardDirs to use /usr/libexec/kde4 instead of /usr/lib${LIBDIRSUFFIX}/kde4/libexec
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.5.80-libexecdir.patch
# kstandarddirs changes: search /etc/kde, find /usr/libexec/kde4
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.5.80-kstandarddirs.patch
zcat ${SB_PATCHDIR}/kdelibs-4.1.70-cmake.patch.gz | patch -p1 --verbose --backup --suffix=.orig
#zcat ${SB_PATCHDIR}/kdelibs-4.3.1-drkonq.patch.gz | patch -p1 --verbose --backup --suffix=.orig

# die rpath die, since we're using standard paths, we can avoid
# this extra hassle (even though cmake is *supposed* to not add standard
# paths (like /usr/lib64) already! With this, we can drop
# -DCMAKE_SKIP_RPATH:BOOL=ON (finally)
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.5.80-no_rpath.patch

# add gpg2 support to knewstuff, rough first try s/gpg/gpg2/
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.5.1-knewstuff_gpg2.patch

# make forcefully hal-free build
patch -p0 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.5.90-halectomy.patch

# Mandriva

# official backports

# Branch upstream
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.6.0-logoutcrash.patch

# Trunk patches

# security fix
## Not Upstreamed? why not ? -- Rex
zcat ${SB_PATCHDIR}/kdelibs-4.3.1-CVE-2009-2702.patch.gz | patch -p1 --verbose --backup --suffix=.orig

set +e +o pipefail
