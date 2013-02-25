
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.5.6-rev3769-embed-vendor-version.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.5.7-external-rev938-libegg-parallel_make.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-rev3873-gtk222.patch

set +e +o pipefail
