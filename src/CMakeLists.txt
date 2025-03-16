function(target_module_if_enabled target)
  cmake_parse_arguments(source "HEADER_ONLY" ""
    "HEADERS;MODULES;SOURCES"  ${ARGN})
  if(source_HEADER_ONLY AND NOT source_HEADERS)
    message(FATAL_ERROR "Target ${target} declared header-only,\
      but no header is supplied")
  endif()

  if(source_HEADER_ONLY AND NOT template_MODULE)
    target_sources(${target}
      INTERFACE FILE_SET HEADERS FILES ${source_HEADERS}
    )
    return()
  endif()

  if(template_MODULE)
    target_sources(${target}
      PUBLIC FILE_SET CXX_MODULES FILES ${source_MODULES}
    )
  else()
    if(source_HEADERS)
      target_sources(${target}
        PUBLIC FILE_SET HEADERS FILES ${source_HEADERS}
      )
    endif()
  endif()
  if(NOT source_SOURCES)
    message(FATAL_ERROR "Target ${target} has no source file")
  endif()
  target_sources(${target}
    PRIVATE
    ${source_SOURCES}
  )
endfunction()
# ---- library definition ----

target_module_if_enabled(template_lib
  HEADERS
  $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/lib.hpp>
  $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}/template/lib.hpp>
  SOURCES
  lib.cpp
  MODULES
  lib.cpp
)
target_link_libraries(template_lib
  PRIVATE
  template_compile_options
)

# ---- testing ----

if(BUILD_TESTING)
  include(GoogleTest)
  find_package(GTest REQUIRED)
  add_executable(template_lib_test)
  target_sources(template_lib_test
    PRIVATE
    lib.test.cpp
  )
  target_link_libraries(template_lib_test
    PRIVATE
    template_lib
    template_compile_options
    GTest::gtest_main
  )
  target_precompile_headers(template_lib_test
    PRIVATE
    <gtest/gtest.h>
  )
  gtest_discover_tests(template_lib_test)
endif()
