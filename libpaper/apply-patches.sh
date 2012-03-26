
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=496126
zcat ${SB_PATCHDIR}/${NAME}-1.1.20-automake_1.10.patch.gz | patch -p1 -E --backup --verbose
# Upstream bug:
# http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=475683
zcat ${SB_PATCHDIR}/${NAME}-1.1.23-debianbug475683.patch.gz | patch -p1 -E --backup --verbose
# Filed upstream as:
# http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=481213
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-useglibcfallback.patch

set +e +o pipefail
