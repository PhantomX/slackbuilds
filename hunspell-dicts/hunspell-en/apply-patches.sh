
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/mozilla_words.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/en_GB-singleletters.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/en_GB.two_initial_caps.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/en_US-strippedabbrevs.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
