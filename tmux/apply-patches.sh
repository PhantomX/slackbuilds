
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# This first patch creates MANDIR in the GNUmakefile.  This has been sent
# upstream via email but upstream replied and said would not change.
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/tmux-1.0-02_fix_wrong_location.diff
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/tmux-1.0-03_proper_socket_handling.diff
# 2010-03-28: Submitted upstream:
# https://sourceforge.net/tracker/?func=detail&aid=2977950&group_id=200378&atid=973264
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/tmux-1.0-04_dropping_unnecessary_privileges.diff
# 2010-03-28: Submitted upstream:
# https://sourceforge.net/tracker/?func=detail&aid=2977945&group_id=200378&atid=973264
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tmux-1.2-writehard.patch

set +e +o pipefail
