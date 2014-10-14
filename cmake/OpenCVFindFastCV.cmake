#
# The script to detect Qualcomm(R) FastCV installation/package
#
# On return this will define:
#
# HAVE_FASTCV       - True if Qualcomm FastCV found
# FASTCV_ROOT_DIR      - root of FastCV installation
# FASTCV_INCLUDE_DIRS  - FastCV include folder
# FASTCV_LIBRARIES     - FastCV libraries that are used by OpenCV
# FASTCV_VERSION_STR   - string with the newest detected FastCV version
# FASTCV_VERSION_MAJOR - numbers of FastCV version (MAJOR.MINOR.BUILD)
# FASTCV_VERSION_MINOR
# FASTCV_VERSION_BUILD
#
# Created: 14 Oct 2014 by Ilya Lavrenov (ilya.lavrenov@itseez.com)
#

unset(HAVE_FASTCV CACHE)
unset(FASTCV_ROOT_DIR)
unset(FASTCV_INCLUDE_DIRS)
unset(FASTCV_LIBRARIES)
unset(FASTCV_VERSION_STR)
unset(FASTCV_VERSION_MAJOR)
unset(FASTCV_VERSION_MINOR)
unset(FASTCV_VERSION_BUILD)

set(FASTCV_LIB_PREFIX ${CMAKE_STATIC_LIBRARY_PREFIX})
set(FASTCV_LIB_SUFFIX ${CMAKE_STATIC_LIBRARY_SUFFIX})

set(FASTCV_X64 0)
if(CMAKE_CXX_SIZEOF_DATA_PTR EQUAL 8)
    set(FASTCV_X64 1)
endif()
if(CMAKE_CL_64)
    set(FASTCV_X64 1)
endif()

# This macro detects FastCV version by analyzing inc/fastcv.h file
macro(fastcv_get_version VERSION_FILE)
  unset(_VERSION_STR)
  unset(_MAJOR)
  unset(_MINOR)
  unset(_BUILD)

  # read FastCV version info from file
  file(STRINGS ${VERSION_FILE} STR REGEX "@version")

  # extract info and assign to variables
  string(REGEX MATCHALL "[0-9]+.[0-9]+.[0-9]+" _VERSION_STR ${STR})
  string(REPLACE "." ";" _VERSION_STR_ARRAY ${_VERSION_STR})

  # export info to parent scope
  set(FASTCV_VERSION_STR ${_VERSION_STR})
  list(GET _VERSION_STR_ARRAY 0 FASTCV_VERSION_MAJOR)
  list(GET _VERSION_STR_ARRAY 1 FASTCV_VERSION_MINOR)
  list(GET _VERSION_STR_ARRAY 2 FASTCV_VERSION_BUILD)
endmacro()

macro(_fastcv_not_supported)
  message(STATUS ${ARGN})
  unset(HAVE_FASTCV)
  unset(FASTCV_VERSION_STR)
  unset(FASTCV_VERSION_MAJOR)
  unset(FASTCV_VERSION_MINOR)
  unset(FASTCV_VERSION_BUILD)
  return()
endmacro()

# detect FastCV 
macro(fastcv_detect_version)
  set(FASTCV_INCLUDE_DIRS ${FASTCV_ROOT_DIR}/inc)

  fastcv_get_version(${FASTCV_INCLUDE_DIRS}/fastcv.h)

  message(STATUS "found FastCV: ${FASTCV_VERSION_MAJOR}.${FASTCV_VERSION_MINOR}.${FASTCV_VERSION_BUILD} [${FASTCV_VERSION_STR}]")
  message(STATUS "at: ${FASTCV_ROOT_DIR}")

  set(HAVE_FASTCV 1)

  macro(_fastcv_set_library_dir DIR)
    if(NOT EXISTS ${DIR})
      _fastcv_not_supported("FastCV library directory not found")
    endif()
    set(FASTCV_LIBRARY_DIR ${DIR})
  endmacro()

  if(ANDROID)
    _fastcv_set_library_dir(${FASTCV_ROOT_DIR}/lib/Android/arm)
  elseif(ARM)
    _fastcv_set_library_dir(${FASTCV_ROOT_DIR}/lib/Linux/arm)
  elseif(WIN32)
    _fastcv_set_library_dir(${FASTCV_ROOT_DIR}/lib/Windows/ia32)
  elseif(UNIX AND FASTCV_X64)
    _fastcv_set_library_dir(${FASTCV_ROOT_DIR}/lib/Linux/ia64)
  endif()

  macro(_fast_add_library name)
    if (EXISTS ${FASTCV_LIBRARY_DIR}/${FASTCV_LIB_PREFIX}${name}${FASTCV_LIB_SUFFIX})
      add_library(${name} STATIC IMPORTED)
      set_target_properties(${name} PROPERTIES
        IMPORTED_LINK_INTERFACE_LIBRARIES ""
        IMPORTED_LOCATION ${FASTCV_LIBRARY_DIR}/${FASTCV_LIB_PREFIX}${name}${FASTCV_LIB_SUFFIX}
      )
      list(APPEND FASTCV_LIBRARIES ${name})
      install(FILES ${FASTCV_LIBRARY_DIR}/${FASTCV_LIB_PREFIX}${name}${FASTCV_LIB_SUFFIX}
              DESTINATION ${OPENCV_3P_LIB_INSTALL_PATH} COMPONENT main)
    else()
      message(STATUS "Can't find FastCV library: ${name} at ${FASTCV_LIBRARY_DIR}/${FASTCV_LIB_PREFIX}${name}${FASTCV_LIB_SUFFIX}")
    endif()
  endmacro()

  _fast_add_library(fastcv)
endmacro()

# OPENCV_FASTCV_PATH is an environment variable
if(DEFINED ENV{OPENCV_FASTCV_PATH})
  set(FASTCV_ROOT "$ENV{OPENCV_FASTCV_PATH}")
endif()

file(TO_CMAKE_PATH "${FASTCV_ROOT}" __FASTCV_ROOT)
if(EXISTS "${__FASTCV_ROOT}/inc/fastcv.h")
  set(FASTCV_ROOT_DIR ${__FASTCV_ROOT})
    fastcv_detect_version()
endif()
