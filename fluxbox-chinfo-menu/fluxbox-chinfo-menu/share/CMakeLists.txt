
set(DATAFILES fluxbox-chinfo-menuconfig
              fluxbox-chinfo-xdg-menu )

set(LANGFILES fluxbox-chinfo-en
              fluxbox-chinfo-pt
              fluxbox-chinfo-pt_BR )

install(FILES ${DATAFILES} DESTINATION "${SHARE_INSTALL_PREFIX}/${PACKAGE}" )
install(FILES ${LANGFILES} DESTINATION "${SHARE_INSTALL_PREFIX}/${PACKAGE}" )
