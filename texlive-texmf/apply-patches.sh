
SB_PATCHDIR=${CWD}/patches

set -e -o pipefail

# patch -p0 -E --backup --verbose -i ${CWD}/${NAME}.patch
zcat ${SB_PATCHDIR}/texlive-2007-badenv.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/texlive-2007-tkdefaults.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/texlive-2007-updmap.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/texlive-2007-texmfconf.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/texlive-2007-romanian.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/texlive-2007-euro.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/texlive-2007-beamerblocks.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/texlive-2007-latin.patch.gz | patch -p1 -E --backup --verbose
patch -p0 -E --backup -z .rb19 --verbose -i ${SB_PATCHDIR}/${NAME}-2007-ruby19.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2007-fmtutil-loop.patch

set +e +o pipefail
