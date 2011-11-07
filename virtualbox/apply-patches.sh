
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# VBOX_WITH_UPDATE to enable/disable update dialog
patch -p1 -E --backup -z .noup --verbose -i ${SB_PATCHDIR}/${NAME}-4.1.2-noupdate.patch

## from Gentoo
# unset useless/problematic mesa checks in configure
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-ose-3.2.8-mesa-check.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.1.4-asneeded.patch
# add the --enable-vnc option to configure script
#patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4-vnc.patch
# Mantain ~/.Virtualbox
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.0.2-restore_old_machines_dir.patch

# from Mandriva
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.0.6-kernelrelease.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-1.6.0_OSE-futex.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/30-usb-warning-filters.patch

# use courier font instead of beramono for older releases where beramono isn't
# available in tetex-latex
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.0.0-user-courier-instead-of-beramono.patch
# don't check for:
# mkisofs: we're not going to build the additions .iso file
# makeself: we're not going to create the stanalone .run installers
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.0.0-dont-check-for-mkisofs-or-makeself.patch
# Set linux 2.6 as default on new machines selector
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-default-to-linux26.patch


patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-OSE-4.0.2-strings.patch
patch -p1 -E --backup -z .libcxx --verbose -i ${SB_PATCHDIR}/${PNAME}-OSE-4.1.2-libcxx.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-OSE-3.2.10-noansi.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-OSE-4.1.2-testmangle.patch

set +e +o pipefail
