# ---- library definition ----

target_sources(template_lib
  PUBLIC
  FILE_SET template_lib_file_set
  TYPE HEADERS FILES
  $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/lib.hpp>
  $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}/template/lib.hpp>
  PRIVATE
  lib.cpp
)
target_link_libraries(template_lib
  PRIVATE
  template_compile_options
)

include(GNUInstallDirs)
install(TARGETS template_lib template_compile_options
  EXPORT templateLib
  FILE_SET template_lib_file_set
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
  PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/template
)
install(EXPORT templateLib
  FILE templateLib.cmake
  NAMESPACE template::
  DESTINATION ${CMAKE_INSTALL_DATADIR}/cmake/template
)

include(CMakePackageConfigHelpers)
write_basic_package_version_file(
  "${PROJECT_BINARY_DIR}/templateConfigVersion.cmake"
  VERSION ${PROJECT_VERSION}
  COMPATIBILITY SameMajorVersion
)

# ---- testing ----

if(BUILD_TESTING)
  include(Catch)

  enable_testing()

  find_package(Catch2 REQUIRED)
  add_executable(template_lib_test)
  target_sources(template_lib_test
    PRIVATE
    lib.test.cpp
  )
  target_link_libraries(template_lib_test
    PRIVATE
    template_lib
    Catch2::Catch2WithMain
  )
  target_compile_features(template_lib_test PRIVATE cxx_std_23)
  catch_discover_tests(template_lib_test
      WORKING_DIRECTORY ${PROJECT_BINARY_DIR})
endif()
