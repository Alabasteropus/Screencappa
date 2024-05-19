@echo off
REM This script is for building and packaging the Screencappa application for Windows.

REM Define the Qt and OpenCV installation paths
SET QT_PATH=C:\Qt\5.15.2\msvc2019_64
SET OPENCV_PATH=C:\OpenCV\build

REM Set the environment variables for Qt and OpenCV
SET PATH=%QT_PATH%\bin;%PATH%
SET CMAKE_PREFIX_PATH=%QT_PATH%;%CMAKE_PREFIX_PATH%
SET PKG_CONFIG_PATH=%OPENCV_PATH%\lib\pkgconfig;%PKG_CONFIG_PATH%

REM Create a build directory and navigate into it
IF NOT EXIST build-windows mkdir build-windows
cd build-windows

REM Run qmake to generate the Makefile
qmake ..\Screencappa.pro -spec win32-msvc

REM Run nmake to build the project
nmake /A

REM Check if the build was successful
IF %ERRORLEVEL% NEQ 0 (
    echo Build failed, exiting...
    exit /b %ERRORLEVEL%
)

REM Bundle the application into an executable
windeployqt Screencappa.exe

REM Create a zip file for distribution
powershell Compress-Archive -Path Screencappa.exe -DestinationPath Screencappa.zip

echo Packaging complete. The Screencappa.zip file is ready for distribution.
