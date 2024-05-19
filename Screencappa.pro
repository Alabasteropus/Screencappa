TEMPLATE = app
TARGET = Screencappa
INCLUDEPATH += $$PWD/include

# Input
SOURCES += src/main.cpp \
           src/screencapture.cpp \
           src/imageprocessor.cpp

HEADERS += src/screencapture.h \
           src/imageprocessor.h

FORMS += src/mainwindow.ui

# Use the OpenCV library
LIBS += -L$$PWD/opencv/build/lib -lopencv_core -lopencv_imgproc -lopencv_highgui

# Use the Qt Widgets module
QT += widgets
