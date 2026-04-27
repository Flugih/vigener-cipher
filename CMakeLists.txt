cmake_minimum_required(VERSION 3.16)

project(crypto VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)
find_package(Qt6 REQUIRED COMPONENTS Core)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appcrypto
    main.cpp
)

qt_add_qml_module(appcrypto
    URI crypto
    VERSION 1.0
    RESOURCE_PREFIX /qt/qml
    QML_FILES
        Main.qml
        # BorderPulse.qml
        # Shake.qml
    SOURCES
        vigenere_crypt.h
        vigenere_crypt.cpp
    RESOURCES

)

qt_add_qml_module(components
    URI crypto.components
    VERSION 1.0
    OUTPUT_DIRECTORY "crypto/components"
    RESOURCE_PREFIX /qt/qml
    QML_FILES
        components/Shake.qml
        components/BorderPulse.qml
        components/CustomField.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appcrypto PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appcrypto
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appcrypto
    PRIVATE
        Qt6::Quick
        components
)

target_include_directories(appcrypto
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/
)

include(GNUInstallDirs)
install(TARGETS appcrypto
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
