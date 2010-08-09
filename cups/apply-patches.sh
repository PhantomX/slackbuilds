
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Fix the USB backend to use either usblp or libusb:
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/usb-backend-both-usblp-and-libusb.dpatch

zcat ${SB_PATCHDIR}/cups-no-gzip-man.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/cups-multilib.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/cups-serial.patch.gz | patch -p1 -E --backup --verbose
#zcat ${SB_PATCHDIR}/cups-serverbin-compat.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-no-export-ssllibs.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-direct-usb-slk.patch
zcat ${SB_PATCHDIR}/cups-lpr-help.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/cups-pid.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/cups-eggcups.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/cups-driverd-timeout.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/cups-usb-paperout.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-res_init.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-uri-compat-slk.patch
zcat ${SB_PATCHDIR}/cups-get-classes.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/cups-avahi.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-str3382.patch
zcat ${SB_PATCHDIR}/cups-0755.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-EAI_AGAIN.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-snmp-quirks.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-hostnamelookups.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-hp-deviceid-oid.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-dnssd-deviceid.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-ricoh-deviceid-oid.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-texttops-rotate-page.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-str3608.patch
# Fix crashes with gecko apps
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cups-1.4.4-str3461-1.4.reverted.patch

## SECURITY PATCHES:

set +e +o pipefail
