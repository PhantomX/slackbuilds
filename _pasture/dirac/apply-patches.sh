
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/dirac-configure.patch.gz | patch -p0 -E --backup --verbose
# http://sourceforge.net/tracker/index.php?func=detail&aid=2984304&group_id=102564&atid=632200
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dirac-gcc45.patch

set +e +o pipefail
