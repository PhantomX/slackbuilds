
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/amarok-2.2.1.90-qtscript_not_required.patch.gz | patch -p1 -E --backup --verbose

## upstream patches
# http://bugs.kde.org/227639
# http://bugs.kde.org/229756
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/a62fed8c667a076daa21fdf8360708813f1bf9e0.patch
# fix mp3-support detection logic
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/50bf5a7e55b08426fd60f4928e65ac066349f83d.patch

set +e +o pipefail
