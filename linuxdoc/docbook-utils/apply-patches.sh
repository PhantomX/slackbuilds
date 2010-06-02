
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/docbook-utils-spaces.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/docbook-utils-2ndspaces.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/docbook-utils-w3mtxtconvert.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/docbook-utils-grepnocolors.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/docbook-utils-sgmlinclude.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/docbook-utils-rtfmanpage.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/docbook-utils-papersize.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/docbook-utils-nofinalecho.patch

set +e +o pipefail
