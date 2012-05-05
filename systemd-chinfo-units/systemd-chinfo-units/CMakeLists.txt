project(chinfo-extramimetypes NONE)

cmake_minimum_required (VERSION 2.8)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)

if(NOT DEFINED SYSTEMD_INSTALL_DIR)
  set(SYSTEMD_INSTALL_DIR "/lib/systemd" CACHE PATH "Where systemd helper files are located")
endif()

if(NOT DEFINED SYSTEMD_SERVICES_INSTALL_DIR)
  set(SYSTEMD_SERVICES_INSTALL_DIR "/lib/systemd/system" CACHE PATH "Where systemd unit files are located")
endif()

set(SYSTEMDFILES    slackware-depmod
                    slackware-motd
                    slackware-lvm-init
                    systemd-clean-dead-links )

set(SYSTEMDSRVSLKFILES slackware-depmod.service
                       slackware-motd.service
                       slackware-lvm-init.service 
                       systemd-clean-dead-links.service )

set(SYSTEMDSRVFILES inet1.service )

install(PROGRAMS ${SYSTEMDFILES} DESTINATION "${SYSTEMD_INSTALL_DIR}" )

foreach (SYSTEMDSRVSLKFILE ${SYSTEMDSRVSLKFILES})
  CONFIGURE_FILE( ${SYSTEMDSRVSLKFILE}.cmake ${SYSTEMDSRVSLKFILE} )
endforeach(SYSTEMDSRVSLKFILE)

foreach (SYSTEMDSRVSLKFILE ${SYSTEMDSRVSLKFILES})
  install(FILES ${CMAKE_CURRENT_BINARY_DIR}/${SYSTEMDSRVSLKFILE} DESTINATION "${SYSTEMD_SERVICES_INSTALL_DIR}" )
endforeach(SYSTEMDSRVSLKFILE)

install(FILES ${SYSTEMDSRVFILES} DESTINATION "${SYSTEMD_SERVICES_INSTALL_DIR}" )
