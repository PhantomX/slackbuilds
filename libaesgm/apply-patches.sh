
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# http://www.gladman.me.uk/cryptography_technology/fileencrypt/
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-20090429-fileencrypt.patch

set +e +o pipefail
