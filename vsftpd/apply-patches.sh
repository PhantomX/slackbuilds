
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/vsftpd.builddefs.diff

# Build patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/vsftpd-2.1.0-libs-slk.patch

# Use /etc/vsftpd/ instead of /etc/
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/vsftpd-2.1.0-configuration-slk.patch

# These need review
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/vsftpd-2.1.0-pam_hostname.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/vsftpd-2.1.0-filter.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/vsftpd-2.1.0-userlist_log.patch

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/vsftpd-2.1.0-trim.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/vsftpd-2.1.1-daemonize_plus.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/vsftpd-2.2.0-wildchar.patch

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/vsftpd-2.2.2-clone.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/vsftpd-2.3.4-sd.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/vsftpd-2.3.4-sqb.patch
#patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/vsftpd-2.3.4-listen_ipv6.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/vsftpd-2.3.5-aslim.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/vsftpd-3.0.0-tz.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/vsftpd-3.0.0-logrotate.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/vsftpd-3.0.2-pasv-addr.patch

set +e +o pipefail
