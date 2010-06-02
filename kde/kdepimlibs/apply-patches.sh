
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.1-t1088138-silent-akonadi.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.1-t1088147-silent-akonadi.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.1-t1088151-add-missing-file.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.1-t1088243-start-akonadi-automatically.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.1-t1088248-reload-agent-list.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.1-t1088257-fix-selftest.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.1-t1088293-silent-akonadi.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.1-t1088321-fix-signal.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.1-t1108274-change-KJob-execution.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.1-t1108279-change-akonadi-server.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.1-t1108288-fix-connect.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.1-t1108308-fix-transaction.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.2-t1101153-add-anew-version-of-custom-fields-for-contacts.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.2-fix-akonadi-crash.patch

set +e +o pipefail
