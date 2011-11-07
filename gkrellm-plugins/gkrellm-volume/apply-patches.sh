
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## Fedora
# Mailed upstream 2010-01-04, #552022
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.1.13-device-updown-552022.patch
# #580165, http://sources.gentoo.org/cgi-bin/viewvc.cgi/gentoo-x86/x11-plugins/gkrellm-volume/files/gkrellm-volume-2.1.13-reenable.patch?revision=1.1&view=markup
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.1.13-reenable.patch

set +e +o pipefail
