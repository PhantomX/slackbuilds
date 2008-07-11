# The set of patches from hell :)

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-3.5.5+flac-1.1.3.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.5.6-config.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.4.0-xdg.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.5.3-examples.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.5.7-pthread.patch.gz | patch -p1 -E --backup --verbose || exit 1

# upstream patches
zcat ${SB_PATCHDIR}/${NAME}-3.5.3-noatun.patch.gz | patch -p1 -E --backup --verbose || exit 1
