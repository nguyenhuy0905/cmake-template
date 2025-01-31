include(GNUInstallDirs)
install(TARGETS template_lib template_compile_options
  EXPORT templateTargets
  FILE_SET template_lib_file_set
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
  PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/template
)
install(EXPORT templateTargets
  FILE templateTargets.cmake
  NAMESPACE template::
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/template
)
include(CMakePackageConfigHelpers)
write_basic_package_version_file(
  "${PROJECT_BINARY_DIR}/templateConfigVersion.cmake"
  VERSION ${PROJECT_VERSION}
  COMPATIBILITY SameMajorVersion
)

install(FILES "${CMAKE_CURRENT_LIST_DIR}/install-config.cmake"
  RENAME "templateConfig.cmake"
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/template
)
install(FILES "${CMAKE_CURRENT_BINARY_DIR}/templateConfigVersion.cmake"
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/template)
