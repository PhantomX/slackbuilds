
set -e -o pipefail

SB_PATCHDIR=${CWD}/tpatches

# patch -p1 -E --backup -z .cookie --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup -z .102434 --verbose -i ${SB_PATCHDIR}/${NAME}-102434.patch
patch -p1 -E --backup -z .cookie --verbose -i ${SB_PATCHDIR}/tigervnc-cookie.patch
zcat ${SB_PATCHDIR}/${NAME}-viewer-reparent.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup -z .ldnow --verbose -i ${SB_PATCHDIR}/${NAME}11-ldnow.patch
patch -p1 -E --backup -z .gethomedir --verbose -i ${SB_PATCHDIR}/${NAME}11-gethomedir.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}11-rh692048.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}11-xorg111.patch

set +e +o pipefail
