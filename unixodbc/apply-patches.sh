
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME};patch
zcat ${SB_PATCHDIR}/depcomp.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/multilib-config.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/warning-cleanup.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/export-symbols.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/libtool-config.patch.gz | patch -p1 -E --backup --verbose
rm -rf config.guess config.sub install-sh ltmain.sh libltdl
zcat ${SB_PATCHDIR}/so-version-bump.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/keep-typedefs.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/odbcint64-config.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/enable-items.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/isql-fixes.patch

set +e +o pipefail
