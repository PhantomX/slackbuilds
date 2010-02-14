# The set of patches from hell :)

SB_PATCHDIR=${CWD}/patches

# make -devel packages parallel-installable
zcat ${SB_PATCHDIR}/kdelibs-4.3.85-parallel_devel.patch.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1
# fix kde#149705
zcat ${SB_PATCHDIR}/kdelibs-4.2.85-kde149705.patch.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1
# Hunspell support for K3Spell
# http://fedoraproject.org/wiki/Releases/FeatureDictionary
# http://bugs.kde.org/show_bug.cgi?id=154561
zcat ${SB_PATCHDIR}/kdelibs-4.0.0-k3spell-hunspell.patch.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1
# install all .css files and Doxyfile.global in kdelibs-common to build
# kdepimlibs-apidocs against
zcat ${SB_PATCHDIR}/kdelibs-4.3.90-install-all-css.patch.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1

# Add "(Slackware)" to khtml user agent
zcat ${SB_PATCHDIR}/kdelibs-4.0.2-branding-slk.patch.gz |sed \
  -e "s|_KDELIBS_SLK_DIST|${KDELIBS_SLK_DIST}|g" | patch -p1 -E --backup --verbose || exit 1

# workaround for policykit
zcat ${SB_PATCHDIR}/kdelibs-4.3.80-policykit-workaround.patch.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1
#zcat ${SB_PATCHDIR}/kdelibs-4.1.0-xdg-menu.patch.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1
# patch KStandardDirs to use %{_libexecdir}/kde4 instead of %{_libdir}/kde4/libexec
zcat ${SB_PATCHDIR}/kdelibs-4.2.85-libexecdir.patch.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1
# kstandarddirs changes: search /etc/kde, find /usr/libexec/kde4
zcat ${SB_PATCHDIR}/kdelibs-4.1.72-kstandarddirs.patch.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1
zcat ${SB_PATCHDIR}/kdelibs-4.1.70-cmake.patch.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1
zcat ${SB_PATCHDIR}/kdelibs-4.3.1-drkonq.patch.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1

# die rpath die, since we're using standard paths, we can avoid
# this extra hassle (even though cmake is *supposed* to not add standard
# paths (like /usr/lib64) already! With this, we can drop
# -DCMAKE_SKIP_RPATH:BOOL=ON (finally)
zcat ${SB_PATCHDIR}/kdelibs-4.3.98-no_rpath.patch.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1

# 4.4 upstream
zcat ${SB_PATCHDIR}/kdelibs-4.4.0-khtml_scrolling.patch.gz | patch -p4 --verbose --backup --suffix=.orig || exit 1
zcat ${SB_PATCHDIR}/kdelibs-4.4.0-nepomuk_memleak.patch.gz | patch -p4 --verbose --backup --suffix=.orig || exit 1

# security fix
## Not Upstreamed? why not ? -- Rex
zcat ${SB_PATCHDIR}/kdelibs-4.3.1-CVE-2009-2702.patch.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1
