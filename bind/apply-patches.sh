
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Remove use of SO_BSDCOMPAT which has been obsolete since the 2.2.x kernel series,
# and generates warnings under 2.6.x kernels:
zcat ${SB_PATCHDIR}/bind.so_bsdcompat.diff.gz | patch -p1 --verbose || exit

# The man pages should reflect /var/run/named:
#zcat ${SB_PATCHDIR}/bind.man.diff.gz | patch -p1 --verbose --backup --suffix=.orig

# Common patches
zcat ${SB_PATCHDIR}/bind-9.5-PIE.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/bind-9.5-dlz-64bit.patch
# needs inpection
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/bind-99-dyndb.patch
zcat ${SB_PATCHDIR}/bind-9.5-parallel-build.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/bind-96-libtool2.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/bind-95-rh452060.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/bind93-rh490837.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/bind97-dist-pkcs11.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/bind97-rh478718.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/bind97-rh570851.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/bind97-exportlib.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/bind97-rh645544.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/bind97-rh693982.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/bind98-rh735103.patch
patch -p0 -E --backup --verbose -d bin/dig -i ${SB_PATCHDIR}/nslookup-norec.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/bind99-buildfix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/bind-9.9.1-P2-dlz-libdb.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/bind-9.9.1-P2-multlib-conflict.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/bind99-rh640538.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/bind97-rh669163.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/bind99-rh985918.patch

# IDN paches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/bind-9.5-libidn.patch
zcat ${SB_PATCHDIR}/bind-9.5-libidn2.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/bind-9.5-libidn3.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/bind95-rh461409.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/bind99-libidn4.patch

set +e +o pipefail
