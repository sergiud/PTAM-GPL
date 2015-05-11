include (FindPackageHandleStandardArgs)

find_path (TooN_INCLUDE_DIR NAMES TooN/TooN.h DOC "TooN include directory")

mark_as_advanced (TooN_INCLUDE_DIR)

add_library (TooN INTERFACE IMPORTED)

if (TooN_INCLUDE_DIR)
  set_target_properties (TooN PROPERTIES INTERFACE_INCLUDE_DIRECTORIES
    ${TooN_INCLUDE_DIR})
endif (TooN_INCLUDE_DIR)

find_package_handle_standard_args (TooN REQUIRED_VARS TooN_INCLUDE_DIR)
