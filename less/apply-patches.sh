
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/less.sysconfdir.patch.gz | patch -p1 --verbose
patch -p1 -E --backup -z .Foption --verbose -i ${SB_PATCHDIR}/less-444-Foption.v2.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/less-394-search.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/less-418-fsync.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/less-436-manpage-add-old-bot-option.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/less-436-help.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/less-458-lessecho-usage.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/less-458-lesskey-usage.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/less-458-old-bot-in-help.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/less-458-outdated-unicode-data.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
