
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/gt-0.4-noac3.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/gt-0.4-compile-fix.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/gt-0.4-optflags.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/gt-0.4-config-default-velocity-layer.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/gt-0.4-ppc-compile-fix.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/gt-0.4-unsf-bigendian-fix.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/gt-0.4-unsf-tremolo.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
