
set(BINFILES fluxbox-chinfo-menu
             fluxbox-dm-helper )

foreach (BINFILE ${BINFILES})

  execute_process(
    INPUT_FILE ${CMAKE_CURRENT_SOURCE_DIR}/${BINFILE}
    COMMAND sed s/\@FCM_VERSION\@/\"${FCM_VERSION}\"/
    OUTPUT_FILE ${CMAKE_CURRENT_BINARY_DIR}/${BINFILE}
  )

endforeach(BINFILE)

foreach (BINFILE ${BINFILES})
  install(PROGRAMS ${CMAKE_CURRENT_BINARY_DIR}/${BINFILE} DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" )
endforeach(BINFILE)
