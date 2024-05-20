#!/bin/bash

# This script is for building and packaging the Screencappa application for Windows using MinGW-w64.

# Define the Qt and OpenCV installation paths
export QT_PATH="/home/ubuntu/qt-everywhere-src-5.15.3/qtbase" # Updated to the Qt base directory
export OPENCV_PATH="/usr/include/opencv4"

# Set the environment variables for Qt and OpenCV
export PATH="$QT_PATH/bin:$PATH"
export CMAKE_PREFIX_PATH="$QT_PATH:$CMAKE_PREFIX_PATH"
export PKG_CONFIG_PATH="$OPENCV_PATH/lib/pkgconfig:$PKG_CONFIG_PATH"

# Create a build directory and navigate into it
mkdir -p build-windows
cd build-windows

# Use the qmake executable found in the system
QMAKE_EXECUTABLE="$QT_PATH/bin/qmake"

# Check if qmake executable is found
if [ ! -f "$QMAKE_EXECUTABLE" ]; then
    echo "qmake executable not found, please check your Qt installation."
    exit 1
fi

# Run qmake to generate the Makefile, specifying the cross-platform spec for MinGW-w64
$QMAKE_EXECUTABLE ../Screencappa.pro -spec win32-g++ CONFIG+=release

# Use the MinGW-w64 make command to build the project
make

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
# Check if the Qt directories exist before copying
QT_DIRECTORIES=("bin" "plugins" "qml" "lib")
for dir in "${QT_DIRECTORIES[@]}"; do
    if [ -d "$QT_PATH/$dir" ]; then
        cp -r "$QT_PATH/$dir" Screencappa-dist/
    else
        echo "Qt $dir directory not found, exiting..."
        exit 1
    fi
done

# Create a zip file for distribution
# Ensure that the Windows executable and all required Qt libraries and plugins are present before zipping
zip -r Screencappa.zip Screencappa-dist/

echo "Packaging complete. The Screencappa.zip file is ready for distribution."
