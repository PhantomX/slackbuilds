
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# https://github.com/PhantomX/slackbuilds/issues/22
# http://4front-tech.com/forum/viewtopic.php?f=3&t=5800
patch -p1 -E --backup --verbose -d ${RSRCDIR} -i ${SB_PATCHDIR}/oss-v4.2-linux-4.0-patch
### Arch
patch -p0 -E --backup --verbose -d ${RSRCDIR} -i ${SB_PATCHDIR}/ossvermagic.patch

set +e +o pipefail
