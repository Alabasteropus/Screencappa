TEMPLATE = app
TARGET = Screencappa
INCLUDEPATH += $$PWD/include \
               /usr/include/opencv4

# Input
SOURCES += src/main.cpp \
           src/screencapture.cpp \
           src/imageprocessor.cpp

HEADERS += src/screencapture.h \
           src/imageprocessor.h

FORMS += src/mainwindow.ui

# Use the OpenCV library
LIBS += -L$$PWD/opencv/build/lib -lopencv_core -lopencv_imgproc -lopencv_highgui
LIBS += `pkg-config --libs opencv4`

# Use the Qt Widgets module
QT += widgets

# Additional configuration for cross-compilation using MinGW-w64
win32 {
    # Define the path to the MinGW-w64 toolchain and Qt for Windows
    MINGW_PATH = /usr/x86_64-w64-mingw32
    WIN_QT_PATH = /usr/local/Qt-5.15.3  # Updated to the correct Qt installation path

    # Update include path and library path for cross-compilation
    INCLUDEPATH += $$WIN_QT_PATH/include \
                   $$MINGW_PATH/include/opencv4
    LIBS += -L$$WIN_QT_PATH/lib -lQt5Widgets -lQt5Gui -lQt5Core
    LIBS += -L$$MINGW_PATH/lib -lopencv_core -lopencv_imgproc -lopencv_highgui

    # Specify the MinGW-w64 compilers
    QMAKE_CC = $$MINGW_PATH/bin/x86_64-w64-mingw32-gcc
    QMAKE_CXX = $$MINGW_PATH/bin/x86_64-w64-mingw32-g++
    QMAKE_LINK = $$MINGW_PATH/bin/x86_64-w64-mingw32-g++
    QMAKE_AR = $$MINGW_PATH/bin/x86_64-w64-mingw32-ar cqs
    QMAKE_OBJCOPY = $$MINGW_PATH/bin/x86_64-w64-mingw32-objcopy
    QMAKE_STRIP = $$MINGW_PATH/bin/x86_64-w64-mingw32-strip

    # Adjust the configuration for Windows specifics
    CONFIG += c++17  # Updated to C++17 to match project requirements
    CONFIG -= app_bundle
    CONFIG += static
}
