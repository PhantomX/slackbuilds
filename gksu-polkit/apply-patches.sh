
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

zcat ${CWD}/${PSRCARCHIVE} | patch -p1 --backup -z .pdeb --verbose
find . -type f -name '*.pdeb' -size 0 -print0 | xargs -0 rm -f

# Patches from GNOME SlackBuild
# Use auth_admin in policy
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.authadmin.diff
# Make sure to send PATH to new environment
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.path.variable.diff

set +e +o pipefail
