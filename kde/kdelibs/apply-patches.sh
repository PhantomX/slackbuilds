# The set of patches from hell :)

set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# make -devel packages parallel-installable
zcat ${SB_PATCHDIR}/kdelibs-4.3.85-parallel_devel.patch.gz | patch -p1 --verbose --backup --suffix=.orig
# fix kde#149705
zcat ${SB_PATCHDIR}/kdelibs-4.2.85-kde149705.patch.gz | patch -p1 --verbose --backup --suffix=.orig
# Hunspell support for K3Spell
# http://fedoraproject.org/wiki/Releases/FeatureDictionary
# http://bugs.kde.org/show_bug.cgi?id=154561
zcat ${SB_PATCHDIR}/kdelibs-4.0.0-k3spell-hunspell.patch.gz | patch -p1 --verbose --backup --suffix=.orig
# install all .css files and Doxyfile.global in kdelibs-common to build
# kdepimlibs-apidocs against
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.3.90-install_all_css.patch

# Add "(Slackware)" to khtml user agent
zcat ${SB_PATCHDIR}/kdelibs-4.0.2-branding-slk.patch.gz |sed \
  -e "s|_KDELIBS_SLK_DIST|${KDELIBS_SLK_DIST}|g" | patch -p1 -E --backup --verbose

# workaround for policykit
zcat ${SB_PATCHDIR}/kdelibs-4.3.80-policykit-workaround.patch.gz | patch -p1 --verbose --backup --suffix=.orig
#zcat ${SB_PATCHDIR}/kdelibs-4.1.0-xdg-menu.patch.gz | patch -p1 --verbose --backup --suffix=.orig
# patch KStandardDirs to use /usr/libexec/kde4 instead of /usr/lib${LIBDIRSUFFIX}/kde4/libexec
zcat ${SB_PATCHDIR}/kdelibs-4.2.85-libexecdir.patch.gz | patch -p1 --verbose --backup --suffix=.orig
# kstandarddirs changes: search /etc/kde, find /usr/libexec/kde4
zcat ${SB_PATCHDIR}/kdelibs-4.1.72-kstandarddirs.patch.gz | patch -p1 --verbose --backup --suffix=.orig
zcat ${SB_PATCHDIR}/kdelibs-4.1.70-cmake.patch.gz | patch -p1 --verbose --backup --suffix=.orig
#zcat ${SB_PATCHDIR}/kdelibs-4.3.1-drkonq.patch.gz | patch -p1 --verbose --backup --suffix=.orig

patch -p1 --verbose --backup --suffix=.orig -i ${SB_PATCHDIR}/kdelibs-4.4.1-add-confirmation-window.patch

# die rpath die, since we're using standard paths, we can avoid
# this extra hassle (even though cmake is *supposed* to not add standard
# paths (like /usr/lib64) already! With this, we can drop
# -DCMAKE_SKIP_RPATH:BOOL=ON (finally)
zcat ${SB_PATCHDIR}/kdelibs-4.3.98-no_rpath.patch.gz | patch -p1 --verbose --backup --suffix=.orig

# 4.4 upstream
# https://bugzilla.redhat.com/585242
# http://bugs.kde.org/206455
patch -p0 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.4.2-kate-inputmethod.patch
# fix kidletime, http://bugs.kde.org/231628, 227279, 218468
( cd kutils/kidletime
  patch -p0 --verbose --backup -i ${SB_PATCHDIR}/kdelibs-4.4.2-kidletime.patch
)
# security fix
## Not Upstreamed? why not ? -- Rex
zcat ${SB_PATCHDIR}/kdelibs-4.3.1-CVE-2009-2702.patch.gz | patch -p1 --verbose --backup --suffix=.orig

set +e +o pipefail
