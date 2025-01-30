include(Catch)

enable_testing()

add_library(template_lib_obj OBJECT)
target_sources(template_lib_obj
  PUBLIC
  FILE_SET HEADERS FILES
  lib.hpp
  PRIVATE
  lib.cpp
)
target_link_libraries(template_lib_obj
  PRIVATE
  template_compile_options
)
target_link_libraries(template_lib
    PUBLIC template_lib_obj
    PRIVATE template_compile_options)

find_package(Catch2 REQUIRED)
add_executable(template_lib_test)
target_sources(template_lib_test
  PRIVATE
  lib.test.cpp
)
target_link_libraries(template_lib_test
  PRIVATE
  template_lib_obj
  Catch2::Catch2WithMain
)
catch_discover_tests(template_lib_test
    WORKING_DIRECTORY ${PROJECT_BINARY_DIR})
