#!/bin/bash

# This script is for packaging the Screencappa application for macOS.

# Check if Homebrew is installed
if ! command -v brew &>/dev/null; then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install Qt and OpenCV using Homebrew
echo "Installing Qt and OpenCV..."
brew install qt opencv

# Define the Qt and OpenCV installation paths
QT_PATH=$(brew --prefix qt)
OPENCV_PATH=$(brew --prefix opencv)

# Export the necessary environment variables for Qt and OpenCV
export PATH="$QT_PATH/bin:$PATH"
export CMAKE_PREFIX_PATH="$QT_PATH:$CMAKE_PREFIX_PATH"
export PKG_CONFIG_PATH="$OPENCV_PATH/lib/pkgconfig:$PKG_CONFIG_PATH"

# Create a build directory and navigate into it
mkdir -p build-macos && cd build-macos

# Run qmake to generate the Makefile
qmake ../Screencappa.pro -spec macx-clang CONFIG+=x86_64

# Run make to build the project
make -j$(sysctl -n hw.ncpu)

# Check if the build was successful
if [ $? -ne 0 ]; then
    echo "Build failed, exiting..."
    exit 1
fi

# Bundle the application into a .app package
macdeployqt Screencappa.app

# Create a .dmg file for distribution
hdiutil create -volname Screencappa -srcfolder Screencappa.app -ov -format UDZO Screencappa.dmg

echo "Packaging complete. The Screencappa.dmg file is ready for distribution."
