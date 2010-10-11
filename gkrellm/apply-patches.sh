
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Increase the default width slightly, and don't use the text
# shadow effect by default (this seems better with Pango font
# rendering):
zcat ${SB_PATCHDIR}/${NAME}.theme.defaults.diff.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.2.4-sansfont.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.2.7-width.patch

set +e +o pipefail
