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

# Run qmake to generate the Makefile, specifying the cross-platform spec for MinGW-w64
qmake ../Screencappa.pro -spec win32-g++

# Run make to build the project
make

# Check if the build was successful
if [ $? -ne 0 ]; then
    echo "Build failed, exiting..."
    exit $?
fi

# The windeployqt tool is not available on Linux, so it is removed from the script.
# Instead, manually collect all necessary Qt libraries and plugins for the Windows executable to run.
# TODO: Identify and copy the necessary Qt libraries and plugins to the build-windows directory.

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

# TODO: Copy the necessary Qt libraries and plugins to the Screencappa-dist directory

# Create a zip file for distribution
# Ensure that the Windows executable and all required Qt libraries and plugins are present before zipping
zip -r Screencappa.zip Screencappa-dist/

echo "Packaging complete. The Screencappa.zip file is ready for distribution."
