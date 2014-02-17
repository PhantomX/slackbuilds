
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/nail-11.25-config.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mailx-12.3-pager.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mailx-12.5-lzw.patch
# resolves: rh#805410
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mailx-12.5-fname-null.patch
# resolves: rh#857120
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mailx-12.5-collect.patch
# resolves: rh#948869
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mailx-12.5-usage.patch

set +e +o pipefail
