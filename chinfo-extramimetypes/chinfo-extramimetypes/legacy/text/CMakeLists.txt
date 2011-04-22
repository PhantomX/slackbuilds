
set(TEXTFILES md5.desktop
              md6.desktop
              sha1.desktop
              sha224.desktop
              sha256.desktop
              sha384.desktop
              sha512.desktop )

install(FILES ${TEXTFILES} DESTINATION "${MIMELNK_INSTALL_DIR}/text" )
