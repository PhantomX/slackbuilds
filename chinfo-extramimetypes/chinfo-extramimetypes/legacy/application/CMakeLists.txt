
set(APPFILES x-bin.desktop
             x-b6t.desktop
             x-c2d.desktop
             x-ccd.desktop
             x-cdi.desktop
             x-daa.desktop
             x-img.desktop
             x-la.desktop
             x-lzma.desktop
             x-maf.desktop
             x-mdf.desktop
             x-mds.desktop
             x-nrg.desktop
             x-ofc.desktop
             x-ofr.desktop
             x-ofs.desktop
             x-shorten.desktop
             x-slackbuild.desktop
             x-tlz.desktop
             x-txz.desktop
             x-xz.desktop
             x-lzma-compressed-tar.desktop
             x-xz-compressed-tar.desktop )

install(FILES ${APPFILES} DESTINATION "${MIMELNK_INSTALL_DIR}/application" )
