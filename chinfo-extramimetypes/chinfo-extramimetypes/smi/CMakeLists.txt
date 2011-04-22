
set(SHARED_MIME_INFO_MINIMUM_VERSION "0.90")
find_package(SharedMimeInfo REQUIRED)

set(SMIFILES chinfo-extramimetypes-cdimage.xml
             chinfo-extramimetypes-gm.xml
             chinfo-extramimetypes-hash.xml
             chinfo-extramimetypes-maf.xml
             chinfo-extramimetypes-slackbuild.xml )

set(XDG_MIME_INSTALL_DIR "${SHARE_INSTALL_PREFIX}/mime/packages" )

install(FILES ${SMIFILES} DESTINATION "${XDG_MIME_INSTALL_DIR}" )
update_xdg_mimetypes(${XDG_MIME_INSTALL_DIR})
