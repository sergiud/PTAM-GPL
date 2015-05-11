cmake_minimum_required (VERSION 3.0)
project (PTAM)

list (APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

set (MAJOR_VERSION 1)
set (MINOR_VERSION 0)
set (VERSION_PATCH 0)

set (SHORT_VERSION "${MAJOR_VERSION}.${MINOR_VERSION}")

if (NOT VERSION_PATCH EQUAL 0)
  set (SHORT_VERSION "${SHORT_VERSION}.${VERSION_PATCH}")
endif (NOT VERSION_PATCH EQUAL 0)

set (VERSION "${MAJOR_VERSION}.${MINOR_VERSION}.${VERSION_PATCH}")

set (CPACK_PACKAGE_NAME PTAM)
set (CPACK_PACKAGE_DESCRIPTION_SUMMARY PTAM)
set (CPACK_PACKAGE_VERSION_MAJOR ${MAJOR_VERSION})
set (CPACK_PACKAGE_VERSION_MINOR ${MINOR_VERSION})
set (CPACK_PACKAGE_VERSION_PATCH ${VERSION_PATCH})
set (CPACK_PACKAGE_VERSION ${SHORT_VERSION})

include (CMakePackageConfigHelpers)
include (CPack)

find_package (GVars3 REQUIRED)
find_package (LibCVD REQUIRED)
find_package (OpenGL REQUIRED)
find_package (TooN REQUIRED)

add_library (ptam
  Src/ARDriver.cc
  Src/ARDriver.h
  Src/ATANCamera.cc
  Src/ATANCamera.h
  Src/Bundle.cc
  Src/Bundle.h
  Src/CalibCornerPatch.cc
  Src/CalibCornerPatch.h
  Src/CalibImage.cc
  Src/CalibImage.h
  Src/CameraCalibrator.cc
  Src/CameraCalibrator.h
  Src/EyeGame.cc
  Src/EyeGame.h
  Src/GLWindow2.cc
  Src/GLWindow2.h
  Src/GLWindowMenu.cc
  Src/GLWindowMenu.h
  Src/HomographyInit.cc
  Src/HomographyInit.h
  Src/KeyFrame.cc
  Src/KeyFrame.h
  Src/LevelHelpers.h
  Src/MEstimator.h
  Src/Map.cc
  Src/Map.h
  Src/MapMaker.cc
  Src/MapMaker.h
  Src/MapPoint.cc
  Src/MapPoint.h
  Src/MapViewer.cc
  Src/MapViewer.h
  Src/MiniPatch.cc
  Src/MiniPatch.h
  Src/OpenGL.h
  Src/PatchFinder.cc
  Src/PatchFinder.h
  Src/Relocaliser.cc
  Src/Relocaliser.h
  Src/ShiTomasi.cc
  Src/ShiTomasi.h
  Src/SmallBlurryImage.cc
  Src/SmallBlurryImage.h
  Src/SmallMatrixOpts.h
  Src/System.cc
  Src/System.h
  Src/Tracker.cc
  Src/Tracker.h
  Src/TrackerData.h
  Src/VideoSource.h
  Src/customFixes.h
  #Src/main.cc
  Src/settingsCustom.h
)

target_include_directories (ptam PUBLIC ${OPENGL_INCLUDE_DIRS})
target_link_libraries (ptam PUBLIC LibCVD GVars3 TooN ${OPENGL_LIBRARIES})

install (TARGETS ptam
  EXPORT ptam-targets
  RUNTIME DESTINATION bin
  PUBLIC_HEADER DESTINATION include
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib)

set (ptam_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Src)

configure_package_config_file (
  ptam-config.cmake.in
  ${CMAKE_CURRENT_BINARY_DIR}/ptam-config.cmake INSTALL_DESTINATION
  lib/cmake/ptam PATH_VARS ptam_INCLUDE_DIR)
write_basic_package_version_file (ptam-config-version.cmake VERSION ${VERSION}
  COMPATIBILITY SameMajorVersion)

set (ptam_INCLUDE_DIR include)

configure_package_config_file (
  ptam-config.cmake.in
  ${CMAKE_CURRENT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/ptam-config.cmake INSTALL_DESTINATION
  lib/cmake/ptam PATH_VARS ptam_INCLUDE_DIR)

export (TARGETS ptam FILE ptam-targets.cmake)
export (PACKAGE ptam)

install (EXPORT ptam-targets DESTINATION lib/cmake/ptam)
install (FILES ${CMAKE_CURRENT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/ptam-config.cmake
  ${CMAKE_CURRENT_BINARY_DIR}/ptam-config-version.cmake DESTINATION
  lib/cmake/ptam)
install (DIRECTORY Src/ DESTINATION include FILES_MATCHING PATTERN "*.h")

set_target_properties (ptam PROPERTIES POSITION_INDEPENDENT_CODE ON)
set_target_properties (ptam PROPERTIES VERSION ${MAJOR_VERSION})
set_target_properties (ptam PROPERTIES SOVERSION ${VERSION})
