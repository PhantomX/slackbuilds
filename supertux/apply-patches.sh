
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.3.5-system-squirrel.patch
# Effectively a revert of upstream commit:
# https://github.com/supertux/supertux/commit/bc25f6fa2616df7e905fed68ceb4e3ebc186a623
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.3.5-squirrel-printfunc.patch

set +e +o pipefail
