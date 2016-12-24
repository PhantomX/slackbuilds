
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

## Slackware
# Fixup sh completion for us
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fixup-sh-script-completions.diff

## Fedora
# https://bugzilla.redhat.com/677446, see also redefine_filedir source
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.99-noblacklist.patch

set +e +o pipefail
