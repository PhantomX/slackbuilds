
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup -z .fix --verbose -i ${SB_PATCHDIR}/${NAME}-5.0.0-fix.patch
patch -p1 -E --backup -z .noup --verbose -i ${SB_PATCHDIR}/${NAME}-5.1.0-noupdate.patch
patch -p1 -E --backup -z .nodkms --verbose -i ${SB_PATCHDIR}/${NAME}-4.2.0-nodkms.patch
patch -p1 -E --backup -z .dso --verbose -i ${SB_PATCHDIR}/${NAME}-4.3.0-dso.patch

## from Gentoo
# unset useless/problematic mesa checks in configure
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-ose-3.2.8-mesa-check.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.1.4-asneeded.patch
# Mantain ~/.Virtualbox
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.0.2-restore_old_machines_dir.patch

# from Mandriva
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.0.6-kernelrelease.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-1.6.0_OSE-futex.patch
#patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/30-usb-warning-filters.patch

# use courier font instead of beramono for older releases where beramono isn't
# available in tetex-latex
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.0.0-user-courier-instead-of-beramono.patch
# don't check for:
# mkisofs: we're not going to build the additions .iso file
# makeself: we're not going to create the stanalone .run installers
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-5.0.0-dont-check-for-mkisofs-or-makeself.patch
# Set linux 2.6 as default on new machines selector
patch -p1 -E --backup -z .defsys --verbose -i ${SB_PATCHDIR}/${NAME}-5.1.0-default-to-linux26.patch
# (tmb) fix build with gsoap >= 2.8.13
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-4.3.0-fix-build-with-gsoap-2.8.13-and-up.patch

if [ "${SB_SYSTEMD}" = "YES" ] ;then
  sed -e 's|/etc/rc.d/rc.vboxdrv restart|systemctl restart vboxdrv.service|g' \
    ${SB_PATCHDIR}/${NAME}-5.1.0-strings.patch | patch -p1 -E --backup -z .istrings --verbose
else
  patch -p1 -E --backup -z .istrings --verbose -i ${SB_PATCHDIR}/${NAME}-5.1.0-strings.patch
fi

patch -p1 -E --backup -z .libcxx --verbose -i ${SB_PATCHDIR}/${PNAME}-4.3.0-libcxx.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-4.3.0-noansi.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-OSE-4.1.2-testmangle.patch

#patch -p0 -E --backup -z .gcc --verbose -i ${SB_PATCHDIR}/${NAME}-5.0.0-gcc.patch

set +e +o pipefail
