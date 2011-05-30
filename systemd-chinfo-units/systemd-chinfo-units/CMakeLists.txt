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

set(SYSTEMDFILES slackware-lvm-init )

set(SYSTEMDSRVFILES display-manager.service
                    network.service
                    slackware-lvm-init.service )

install(PROGRAMS ${SYSTEMDFILES} DESTINATION "${SYSTEMD_INSTALL_DIR}" )
install(FILES ${SYSTEMDSRVFILES} DESTINATION "${SYSTEMD_SERVICES_INSTALL_DIR}" )
