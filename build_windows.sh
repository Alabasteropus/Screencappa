#!/bin/bash

# This script is for building and packaging the Screencappa application for Windows using MinGW-w64.

# Define the Qt and OpenCV installation paths
export QT_PATH="/usr/local/Qt-5.15.3" # Updated to the new Qt installation path
export OPENCV_PATH="/usr/include/opencv4"

# Set the environment variables for Qt and OpenCV
export PATH="$QT_PATH/bin:$PATH"
export CMAKE_PREFIX_PATH="$QT_PATH:$CMAKE_PREFIX_PATH"
export PKG_CONFIG_PATH="$OPENCV_PATH/lib/pkgconfig:$PKG_CONFIG_PATH"

# Create a build directory and navigate into it
mkdir -p build-windows
cd build-windows

# Placeholder for the qmake executable path, to be updated after Qt build completion
QMAKE_EXECUTABLE=""

# Check for the MinGW-w64 qmake executable in the expected directory
if [ -f "/usr/local/Qt-5.15.3/bin/qmake" ]; then
    QMAKE_EXECUTABLE="/usr/local/Qt-5.15.3/bin/qmake"
elif [ -f "/usr/bin/x86_64-w64-mingw32-qmake" ]; then
    QMAKE_EXECUTABLE="/usr/bin/x86_64-w64-mingw32-qmake"
else
    echo "MinGW-w64 qmake executable not found, please check your Qt installation."
    exit 1
fi

# Run qmake to generate the Makefile, specifying the cross-platform spec for MinGW-w64
$QMAKE_EXECUTABLE ../Screencappa.pro -spec win32-g++ CONFIG+=release

# Use the standard make command to build the project
/usr/bin/make

# Check if the build was successful
if [ $? -ne 0 ]; then
    echo "Build failed, exiting..."
    exit $?
fi

# The windeployqt tool is not available on Linux, so it is removed from the script.
# Instead, manually collect all necessary Qt libraries and plugins for the Windows executable to run.

# Navigate to the directory containing the Windows executable
cd release # Assuming the executable is in the 'release' directory

# Verify that the Screencappa executable exists
if [ ! -f Screencappa.exe ]; then
    echo "Screencappa.exe not found, exiting..."
    exit 1
fi

# Create a directory to collect all necessary files for distribution
mkdir -p Screencappa-dist
cp Screencappa.exe Screencappa-dist/

# Copy the necessary Qt libraries and plugins to the Screencappa-dist directory
cp -r "$QT_PATH/bin" Screencappa-dist/
cp -r "$QT_PATH/plugins" Screencappa-dist/
cp -r "$QT_PATH/qml" Screencappa-dist/
cp -r "$QT_PATH/lib" Screencappa-dist/

# Create a zip file for distribution
# Ensure that the Windows executable and all required Qt libraries and plugins are present before zipping
zip -r Screencappa.zip Screencappa-dist/

echo "Packaging complete. The Screencappa.zip file is ready for distribution."
