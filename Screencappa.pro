TEMPLATE = app
TARGET = Screencappa
INCLUDEPATH += $$PWD/include

# Input
SOURCES += main.cpp \
           screencapture.cpp \
           imageprocessor.cpp

HEADERS += screencapture.h \
           imageprocessor.h

FORMS += mainwindow.ui

# Use the OpenCV library
LIBS += -L$$PWD/opencv/build/lib -lopencv_core -lopencv_imgproc -lopencv_highgui

# Use the Qt Widgets module
QT += widgets
