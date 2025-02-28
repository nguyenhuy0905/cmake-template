# ---- library definition ----

if(template_MODULE)
  target_sources(template_lib_module
    PUBLIC
    FILE_SET CXX_MODULES FILES
    lib.cpp
  )
  target_link_libraries(template_lib_module
    PRIVATE
    template_compile_options
  )
else()
  target_sources(template_lib
    PUBLIC
    FILE_SET HEADERS FILES
    $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/lib.hpp>
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}/template/lib.hpp>
    PRIVATE
    lib.cpp
  )
  target_link_libraries(template_lib
    PRIVATE
    template_compile_options
  )
endif()

# ---- testing ----

if(BUILD_TESTING)
  include(Catch)

  find_package(Catch2 REQUIRED)
  add_executable(template_lib_test)
  target_sources(template_lib_test
    PRIVATE
    lib.test.cpp
  )
  if(template_MODULE)
    target_link_libraries(template_lib_test
      PRIVATE
      template_lib_module
      template_compile_options
      Catch2::Catch2WithMain
    )
  else()
    target_link_libraries(template_lib_test
      PRIVATE
      template_lib
      template_compile_options
      Catch2::Catch2WithMain
    )
  endif()
  target_precompile_headers(template_lib_test
    PRIVATE
    <catch2/catch_test_macros.hpp>
  )
  catch_discover_tests(template_lib_test
      WORKING_DIRECTORY ${PROJECT_BINARY_DIR})
endif()
