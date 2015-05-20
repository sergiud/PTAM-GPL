include (FindPackageHandleStandardArgs)

find_path (GVars3_INCLUDE_DIR NAMES gvars3/config.h gvars3/gvars3.h
  DOC "GVars3 include directory")
find_library (GVars3_LIBRARY NAMES GVars3 DOC "GVars3 release library")

mark_as_advanced (GVars3_INCLUDE_DIR GVars3_LIBRARY)

add_library (GVars3 UNKNOWN IMPORTED)

if (GVars3_INCLUDE_DIR)
  set_target_properties (GVars3 PROPERTIES INTERFACE_INCLUDE_DIRECTORIES
    ${GVars3_INCLUDE_DIR})
endif (GVars3_INCLUDE_DIR)

set_target_properties (GVars3 PROPERTIES IMPORTED_LOCATION ${GVars3_LIBRARY})

set (GVars3_INCLUDE_DIRS ${GVars3_INCLUDE_DIR})
set (GVars3_LIBRARIES ${GVars3_LIBRARY})

find_package_handle_standard_args (GVars3 REQUIRED_VARS GVars3_INCLUDE_DIR
  GVars3_LIBRARY)
