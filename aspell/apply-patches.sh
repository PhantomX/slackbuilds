
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/aspell-0.60.3-install_info.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/aspell-0.60.5-fileconflict.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/aspell-0.60.5-pspell_conf.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/aspell-0.60.6-zero.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
