
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# https://projects.kde.org/projects/kde/kdegraphics/gwenview/repository/revisions/2945372b9c20a7041858a861aa11385551dd506b
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.8.1-gvpart_cursor.patch
# https://projects.kde.org/projects/kde/kdegraphics/gwenview/repository/revisions/83f424c9feb291e491920357d4ad6949e767e169
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.8.1-gvpart_documentviewcontainter.patch

set +e +o pipefail
