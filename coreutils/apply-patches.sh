  
SB_PATCHDIR=${CWD}/patches

# Patch in the uname for Linux enhancements
if [ "${SB_RHUNAME}" = "YES" ] ;then
  # Fedora/Red Hat patch.
  zcat ${SB_PATCHDIR}/${NAME}-4.5.3-sysinfo.patch.gz | patch -p1 -E --backup --verbose || exit 1
else
  # Slackware patch
  zcat ${SB_PATCHDIR}/${NAME}.uname.diff.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1
fi

# From upstream

# Our patches
zcat ${SB_PATCHDIR}/${NAME}-6.10-configuration.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-6.10-manpages.patch.gz | patch -p1 -E --backup --verbose || exit 1

# sh-utils
zcat ${SB_PATCHDIR}/sh-utils-2.0.11-dateman.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/sh-utils-1.16-paths.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-4.5.3-langinfo.patch.gz | patch -p1 -E --backup --verbose || exit 1

# (sb) lin18nux/lsb compliance
zcat ${SB_PATCHDIR}/${NAME}-i18n.patch.gz | patch -p1 -E --backup --verbose || exit 1

zcat ${SB_PATCHDIR}/${NAME}-getgrouplist.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-overflow.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-getfacl-exit-code.patch.gz | patch -p1 -E --backup --verbose || exit 1
