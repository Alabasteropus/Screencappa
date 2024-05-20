# Screencappa Setup Instructions for Windows

## Prerequisites
- Git
- MinGW-w64
- Qt 5.15.3

## Cloning the Repository
1. Open Git Bash or your preferred terminal.
2. Clone the Screencappa repository using the following command:
   ```
   git clone https://github.com/Alabasteropus/Screencappa.git
   ```
3. Navigate to the cloned repository's directory:
   ```
   cd Screencappa
   ```

## Installing Dependencies
1. Install Qt 5.15.3 for Windows from the official Qt website. You can download it from [Qt's official download page](https://www.qt.io/download-qt-installer). Follow the instructions provided by the installer.
2. Ensure MinGW-w64 is installed and properly configured in your system's PATH. You can download it from [MinGW-w64's official page](https://mingw-w64.org/doku.php/download). Follow the installation instructions and add the bin directory to your system's PATH.

## Compiling the Application
1. Open the Qt Command Prompt from the Start Menu.
2. Navigate to the Screencappa project directory.
3. Run the following command to prepare the build environment:
   ```
   qmake Screencappa.pro -spec win32-g++ "CONFIG+=qtquickcompiler"
   ```
4. Compile the project using the following command:
   ```
   make
   ```

## Running the Application
1. After successful compilation, navigate to the `release` or `debug` directory, depending on your build configuration.
2. Run the Screencappa executable to launch the application.

## Troubleshooting
- If you encounter any issues with missing dependencies or errors during compilation, ensure that the Qt and MinGW-w64 paths are correctly set in your system's PATH and that the versions match the project requirements.
- For any other issues, refer to the Qt documentation or the Screencappa repository's issue tracker.

Thank you for setting up Screencappa on your Windows environment. For further assistance, please reach out through the repository's issue tracker.
