include (FindPackageHandleStandardArgs)

find_path (LibCVD_INCLUDE_DIR NAMES cvd/cvd_image.h DOC "LibCVD include directory")
find_library (LibCVD_LIBRARY_RELEASE NAMES cvd DOC "LibCVD release library")
find_library (LibCVD_LIBRARY_DEBUG NAMES cvd_debug DOC "LibCVD debug library")

add_library (LibCVD UNKNOWN IMPORTED)

if (LibCVD_INCLUDE_DIR)
  set_target_properties (LibCVD PROPERTIES INTERFACE_INCLUDE_DIRECTORIES
    ${LibCVD_INCLUDE_DIR})
endif (LibCVD_INCLUDE_DIR)

if (LibCVD_LIBRARY_RELEASE)
  set_target_properties (LibCVD PROPERTIES IMPORTED_LOCATION
    ${LibCVD_LIBRARY_RELEASE})
  set_target_properties (LibCVD PROPERTIES IMPORTED_LOCATION_RELEASE
    ${LibCVD_LIBRARY_RELEASE})
endif (LibCVD_LIBRARY_RELEASE)

if (LibCVD_LIBRARY_DEBUG AND LibCVD_LIBRARY_RELEASE)
  set (LibCVD_LIBRARY optimized ${LibCVD_LIBRARY_RELEASE} debug
    ${LibCVD_LIBRARY_DEBUG} CACHE PATH "LibCVD library")
elseif (LibCVD_LIBRARY_RELEASE)
  set (LibCVD_LIBRARY ${LibCVD_LIBRARY_RELEASE} CACHE PATH "LibCVD library")
elseif (LibCVD_LIBRARY_DEBUG)
  set (LibCVD_LIBRARY ${LibCVD_LIBRARY_DEBUG} CACHE PATH "LibCVD library")
endif (LibCVD_LIBRARY_DEBUG AND LibCVD_LIBRARY_RELEASE)

mark_as_advanced (LibCVD_INCLUDE_DIR LibCVD_LIBRARY_RELEASE LibCVD_LIBRARY_DEBUG
    LibCVD_LIBRARY)

set (_LibCVD_CONFIG_H ${LibCVD_INCLUDE_DIR}/cvd/config.h)

if (EXISTS "${_LibCVD_CONFIG_H}")
  file (READ "${_LibCVD_CONFIG_H}" _TMP)

  string (REGEX REPLACE ".*CVD_MAJOR_VERSION[ \t]+([0-9]+).*" "\\1"
    LibCVD_VERSION_MAJOR "${_TMP}")
  string (REGEX REPLACE ".*CVD_MINOR_VERSION[ \t]+([0-9]+).*" "\\1"
    LibCVD_VERSION_MINOR "${_TMP}")

  set (LibCVD_VERSION ${LibCVD_VERSION_MAJOR}.${LibCVD_VERSION_MINOR})
  set (LibCVD_VERSION_COMPONENTS 2)
endif (EXISTS "${_LibCVD_CONFIG_H}")

find_package_handle_standard_args (LibCVD REQUIRED_VARS LibCVD_INCLUDE_DIR
  LibCVD_LIBRARY VERSION_VAR LibCVD_VERSION)
