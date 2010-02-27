
SB_PATCHDIR=${CWD}/patches

set -e -o pipefail

zcat ${SB_PATCHDIR}/${NAME}-4.1.80-nsplugins-paths.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-4.1.70-konsole-session.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-4.2.1-home-icon-slk.patch.gz | patch -p1 -E --backup --verbose

## upstream patches
# remove extra spaces from konsole selections, https://bugzilla.redhat.com/560721
zcat ${SB_PATCHDIR}/${NAME}-4.3.95-konsole-extra-spaces.patch.gz | patch -p1 -E --backup --verbose

# https://bugs.kde.org/show_bug.cgi?id=227157
zcat ${SB_PATCHDIR}/${NAME}-4.4.0-folderview-sorting-kde\#227157.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
