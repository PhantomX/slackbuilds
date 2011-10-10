
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

zcat ${SB_PATCHDIR}/git-1.5-gitweb-home-link.patch.gz | patch -p1 -E --backup --verbose
# https://bugzilla.redhat.com/490602
zcat ${SB_PATCHDIR}/git-cvsimport-Ignore-cvsps-2.2b1-Branches-output.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
