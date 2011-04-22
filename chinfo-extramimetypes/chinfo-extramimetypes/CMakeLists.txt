project(chinfo-extramimetypes NONE)

cmake_minimum_required (VERSION 2.8)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)

if(NOT DEFINED SHARE_INSTALL_PREFIX)
  set(SHARE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}/share" )
endif()

option(CHINFO_LEGACY "Add legacy KDE3 desktop files" OFF)

add_subdirectory(smi)
if(CHINFO_LEGACY)
  add_subdirectory(legacy)
endif()
