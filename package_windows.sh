#!/bin/bash
# This script is for packaging the Screencappa application for Windows using Wine on Linux.

# Define the Qt and OpenCV installation paths for Wine
QT_PATH="~/.wine/drive_c/Qt/5.15.2/msvc2019_64"
OPENCV_PATH="~/.wine/drive_c/OpenCV/build"

# Set the environment variables for Qt and OpenCV
export PATH="$QT_PATH/bin:$PATH"
export CMAKE_PREFIX_PATH="$QT_PATH:$CMAKE_PREFIX_PATH"
export PKG_CONFIG_PATH="$OPENCV_PATH/lib/pkgconfig:$PKG_CONFIG_PATH"

# Create a build directory and navigate into it
if [ ! -d "build-windows" ]; then
  mkdir build-windows
fi
cd build-windows

# Run qmake to generate the Makefile, specifying the use of Wine
wine qmake ../Screencappa.pro -spec win32-msvc

# Run nmake to build the project, specifying the use of Wine
wine nmake /A

# Check if the build was successful
if [ $? -ne 0 ]; then
    echo "Build failed, exiting..."
    exit 1
fi

# Bundle the application into an executable using Wine
wine windeployqt Screencappa.exe

# Create a zip file for distribution using Wine
wine powershell Compress-Archive -Path Screencappa.exe -DestinationPath Screencappa.zip

echo "Packaging complete. The Screencappa.zip file is ready for distribution."
