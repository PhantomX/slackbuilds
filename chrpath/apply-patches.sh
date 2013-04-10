
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-multilib.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-keepgoing.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.13-NULL-entry.patch
# https://bugzilla.redhat.com/show_bug.cgi?id=868611
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.13-getopt_long.patch

set +e +o pipefail
