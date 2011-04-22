project(konqinfohelper)
set(PACKAGE konqinfohelper)

cmake_minimum_required (VERSION 2.8)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

find_package(KDE4 REQUIRED)
include(KDE4Defaults)

if(NOT DEFINED SHARE_INSTALL_PREFIX)
  set(SHARE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}/share" )
endif()

add_subdirectory(bin)
add_subdirectory(servicemenus)
