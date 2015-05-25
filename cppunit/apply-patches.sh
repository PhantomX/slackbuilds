
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
zcat ${SB_PATCHDIR}/cppunit-1.12.0-nolibdir.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cppunit-msg.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cppunit-warnings-sf2912630.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
