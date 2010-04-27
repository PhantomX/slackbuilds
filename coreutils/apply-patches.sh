
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# Patch in the uname for Linux enhancements
if [ "${SB_RHUNAME}" = "YES" ] ;then
  # Fedora/Red Hat patch.
  zcat ${SB_PATCHDIR}/${NAME}-4.5.3-sysinfo.patch.gz | patch -p1 -E --backup --verbose
else
  # Slackware patch
  zcat ${SB_PATCHDIR}/${NAME}.uname.diff.gz | patch -p1 --verbose --backup --suffix=.orig
fi

# From upstream

# Fedora patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-6.10-configuration.patch
# add note about no difference between binary/text mode on Linux - md5sum manpage
zcat ${SB_PATCHDIR}/${NAME}-6.10-manpages.patch.gz | patch -p1 -E --backup --verbose
# temporarily workaround probable kernel issue with TCSADRAIN
zcat ${SB_PATCHDIR}/${NAME}-7.4-sttytcsadrain.patch.gz | patch -p1 -E --backup --verbose
#df --direct
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-df-direct.patch

# sh-utils
# add info about TZ envvar to date manpage
zcat ${SB_PATCHDIR}/sh-utils-2.0.11-dateman.patch.gz | patch -p1 -E --backup --verbose
# set paths for su explicitly, don't get influenced by paths.h
zcat ${SB_PATCHDIR}/sh-utils-1.16-paths.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-4.5.3-langinfo.patch.gz | patch -p1 -E --backup --verbose

# (sb) lin18nux/lsb compliance
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-i18n.patch

if [ "${SB_PAM}" = "YES" ] ; then
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-pam.patch
  zcat ${SB_PATCHDIR}/${NAME}-setsid.patch.gz | patch -p1 -E --backup --verbose
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-5.2.1-runuser.patch
  zcat ${SB_PATCHDIR}/${NAME}-split-pam.patch.gz | patch -p1 -E --backup --verbose
fi

# getgrouplist() patch from Ulrich Drepper.
zcat ${SB_PATCHDIR}/${NAME}-getgrouplist.patch.gz | patch -p1 -E --backup --verbose
# Prevent buffer overflow in who(1).
zcat ${SB_PATCHDIR}/${NAME}-overflow.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-getfacl-exit-code.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
