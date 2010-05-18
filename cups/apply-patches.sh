
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# Fix the USB backend to use either usblp or libusb:
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/usb-backend-both-usblp-and-libusb.dpatch

zcat ${SB_PATCHDIR}/cups-no-gzip-man.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/cups-multilib.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/cups-serial.patch.gz | patch -p1 -E --backup --verbose
#zcat ${SB_PATCHDIR}/cups-serverbin-compat.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-no-export-ssllibs.patch
zcat ${SB_PATCHDIR}/cups-direct-usb.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/cups-lpr-help.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/cups-pid.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/cups-eggcups.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/cups-driverd-timeout.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/cups-usb-paperout.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-res_init.patch
zcat ${SB_PATCHDIR}/cups-uri-compat.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/cups-get-classes.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/cups-avahi.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-str3382.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-str3503.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-str3399.patch
#zcat ${SB_PATCHDIR}/cups-gnutls-gcrypt-threads.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/cups-0755.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-EAI_AGAIN.patch
zcat ${SB_PATCHDIR}/cups-str3505.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-str3541.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-snmp-quirks.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-hp-deviceid-oid.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-dnssd-deviceid.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-ricoh-deviceid-oid.patch

## SECURITY PATCHES:
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-CVE-2010-0302.patch

set +e +o pipefail
