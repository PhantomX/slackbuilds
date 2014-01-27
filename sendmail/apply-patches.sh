
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/sendmail-8.14.4-makemapman.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/sendmail-8.14.3-smrsh_paths.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sendmail-8.14.8-pid-slk.patch
zcat ${SB_PATCHDIR}/sendmail-8.12.7-hesiod.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/sendmail-8.12.7-manpage.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sendmail-8.14.8-dynamic.patch
zcat ${SB_PATCHDIR}/sendmail-8.13.0-cyrus.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/sendmail-8.14.4-aliases_dir.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/sendmail-8.13.7-vacation-slk.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sendmail-8.14.8-noversion.patch
zcat ${SB_PATCHDIR}/sendmail-8.13.1-localdomain.patch.gz | patch -p1 -E --backup --verbose
cp devtools/M4/UNIX/{,shared}library.m4
zcat ${SB_PATCHDIR}/sendmail-8.14.3-sharedmilter.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/sendmail-8.14.4-switchfile.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/sendmail-8.14.3-milterfdleaks.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/sendmail-8.14.3-ipv6-bad-helo.patch.gz | patch -p1 -E --backup --verbose
# fix compilation with libdb5
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-8.14.4-libdb5.patch
# silence warning about missing sasl2 config in /usr/lib*, now in /etc/sasl2
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-8.14.4-sasl2-in-etc.patch
# add QoS support, patch from Philip Prindeville <philipp@fedoraproject.org>
# upstream reserved option ID 0xe7 for testing of this new feature, #576643
sed -e "s|\`/run/|\`/var/run/|g" ${SB_PATCHDIR}/${NAME}-8.14.7-qos.patch \
  | patch -p1 -E --backup --verbose

set +e +o pipefail
