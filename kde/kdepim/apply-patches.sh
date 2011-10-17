
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup -z .install-headers --verbose -i ${SB_PATCHDIR}/${NAME}-4.5.85-install-headers.patch

# disable nepomuk/strigi notification spam 
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.7.2-nepomuk_notification.patch
# fix KMail migration (kde#283563)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.7.2-kmail-migration.patch

# Trunk Patches

# upstream patches

set +e +o pipefail
