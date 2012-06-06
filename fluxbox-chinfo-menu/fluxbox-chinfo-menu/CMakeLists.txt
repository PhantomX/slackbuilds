project(fluxbox-chinfo-menu NONE)
set(PACKAGE fluxbox-chinfo-menu)

cmake_minimum_required (VERSION 2.8)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

if(NOT DEFINED SHARE_INSTALL_PREFIX)
  set(SHARE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}/share" )
endif()

add_subdirectory(bin)
add_subdirectory(po)
add_subdirectory(share)
