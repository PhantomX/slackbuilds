
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/02-select-default-user.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/04-autorestart.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/06-authentication-failure-string.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/08-fresh-x11-timestamps.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-auth-dialog-make-the-label-wrap-at-70-chars.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/remove_g_type_init.patch

set +e +o pipefail
