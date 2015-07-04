
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/sendmail-8.14.4-makemapman.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/sendmail-8.14.3-smrsh_paths.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sendmail-8.14.9-pid-slk.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sendmail-8.15.1-manpage.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sendmail-8.15.1-dynamic.patch
zcat ${SB_PATCHDIR}/sendmail-8.13.0-cyrus.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sendmail-8.15.1-aliases_dir.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sendmail-8.14.9-vacation-slk.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sendmail-8.14.9-noversion.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sendmail-8.15.1-localdomain.patch
cp devtools/M4/UNIX/{,shared}library.m4
zcat ${SB_PATCHDIR}/sendmail-8.14.3-sharedmilter.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sendmail-8.15.1-switchfile.patch
# silence warning about missing sasl2 config in /usr/lib*, now in /etc/sasl2
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-8.14.8-sasl2-in-etc.patch
# add QoS support, patch from Philip Prindeville <philipp@fedoraproject.org>
# upstream reserved option ID 0xe7 for testing of this new feature, #576643
sed -e "s|\`/run/|\`/var/run/|g" ${SB_PATCHDIR}/${NAME}-8.15.1-qos.patch \
  | patch -p1 -E --backup --verbose

set +e +o pipefail
