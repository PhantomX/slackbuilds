
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/glm-0.9.5.2-smallercount.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/glm-0.9.6.1-ulp.patch
# https://bugzilla.redhat.com/show_bug.cgi?id=1185298
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/glm-0.9.6.1-bigendian.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/glm-0.9.6.3-nom64.patch

set +e +o pipefail
