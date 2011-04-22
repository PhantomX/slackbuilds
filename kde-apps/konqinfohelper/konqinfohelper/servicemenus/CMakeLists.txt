
set(TSRVFILES aviinfo.desktop
             gifinfo.desktop
             jpginfo.desktop
             m4ainfo.desktop
             mkvinfo.desktop
             mp3info.desktop
             mpginfo.desktop
             ogginfo.desktop
             pdfkinfo.desktop
             pnginfo.desktop
             tgainfo.desktop
             torrentinfo.desktop
             wavinfo.desktop )

set(SRV_INSTALL_DIR "${SERVICES_INSTALL_DIR}/ServiceMenus" )

foreach (SRVFILE ${TSRVFILES})
  CONFIGURE_FILE( ${SRVFILE}.cmake ${SRVFILE} )
endforeach(SRVFILE)

foreach (SRVFILE ${TSRVFILES})
  install(FILES ${CMAKE_CURRENT_BINARY_DIR}/${SRVFILE} DESTINATION "${SRV_INSTALL_DIR}" )
endforeach(SRVFILE)
