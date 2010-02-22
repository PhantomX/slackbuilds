  
SB_PATCHDIR=${CWD}/patches

( set -e
  zcat ${SB_PATCHDIR}/texlive-2007-badenv.patch.gz | patch -p0 -E --backup --verbose
  zcat ${SB_PATCHDIR}/texlive-2007-tkdefaults.patch.gz | patch -p0 -E --backup --verbose
  zcat ${SB_PATCHDIR}/texlive-2007-updmap.patch.gz | patch -p1 -E --backup --verbose
  zcat ${SB_PATCHDIR}/texlive-2007-texmfconf.patch.gz | patch -p1 -E --backup --verbose
  zcat ${SB_PATCHDIR}/texlive-2007-romanian.patch.gz | patch -p0 -E --backup --verbose
  zcat ${SB_PATCHDIR}/texlive-2007-euro.patch.gz | patch -p0 -E --backup --verbose
  zcat ${SB_PATCHDIR}/texlive-2007-beamerblocks.patch.gz | patch -p0 -E --backup --verbose
  zcat ${SB_PATCHDIR}/texlive-2007-latin.patch.gz | patch -p1 -E --backup --verbose
)
