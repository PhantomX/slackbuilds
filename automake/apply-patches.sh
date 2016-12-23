
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.15-disable-vala-tests.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.15-perl-escape-curly-bracket.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.15-dejagnu-testcase.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.15-avoid-dist-GZIP-var.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
