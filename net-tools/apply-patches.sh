
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${CWD}/${PSRCARCHIVE} | patch -p1 -E --backup --verbose || exit 1
for patch in $(<debian/patches/series) ;do
  patch -p1 -i "debian/patches/${patch}" || exit 1
done

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.60-fgets.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.60-netstat-probe.patch
# scanf format length fix (non-exploitable)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.60-scanf-format.patch
# netstat - avoid name resolution for listening or established sockets (-l) by return fast
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.60-avoid-name-resolution.patch
# handle raw "IP" masqinfo
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.60-masqinfo-raw-ip.patch
# slattach: use fchown() rather than chown() to avoid race between creation and permission changing
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.60-slattach-fchown.patch
# Fix the handling of some of the HAVE_* flags ifdef vs if. (BerliOS #17812)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.60-ifdef-vs-if.patch
# Don't rely on eth0 being default network device name.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.60-arbitrary-device-names.patch
# patch netstat to separate basename of -p only if it is absolute
# path (in order to make argv[0]="sshd pty/0" display as sshd, and not as /0).
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.60-netstat-p-basename.patch

set +e +o pipefail
