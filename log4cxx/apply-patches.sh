
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Filed into upstream bugtracker at:
# https://issues.apache.org/jira/browse/LOGCXX-332
zcat ${SB_PATCHDIR}/${NAME}-cstring.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
