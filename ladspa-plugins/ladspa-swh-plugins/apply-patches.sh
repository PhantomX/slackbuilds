
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/swh-plugins-0.4.15-pic.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/swh-plugins-0.4.15-riceitdown.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/swh-plugins-0.4.15-gettext.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
