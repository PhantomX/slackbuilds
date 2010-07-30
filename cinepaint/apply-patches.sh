
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-0.22-0-icc_helfer_fltk.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-0.22-0-nonweak-symbol.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-0.22-0-rm_rpath.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-0.22-0-pc_req.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-0.22-0-libdir.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-0.22-md5_rm_RSA.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-0.22-multilib.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-0.22-gcc43_cine.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/cinepaint-0.22-1-underquoted.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/cinepaint-0.22-gcc44.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/cinepaint-0.22-oyranos19.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.22-1-dso.patch

( cd ${SRCDIR2}
  zcat ${SB_PATCHDIR}/icc_examin-0.46-default.patch.gz | patch -p1 -E --backup --verbose
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/icc_examin-0.46-overflow.patch
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/icc_examin-0.46-dso.patch
)

set +e +o pipefail
