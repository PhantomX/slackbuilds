
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# https://developer.pidgin.im/ticket/15517
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pidgin-2.10.7-link-libirc-to-libsasl2.patch

# Revert this fix for the time (jabber crashing on connection)
# https://developer.pidgin.im/ticket/15327
patch -p1 -R -E --backup --verbose -i ${SB_PATCHDIR}/pidgin-2.10.7-bug15327.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
