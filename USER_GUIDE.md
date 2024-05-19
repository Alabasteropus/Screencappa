# Screencappa User Guide

Welcome to Screencappa, the dynamic screencapture tool designed for efficiency and ease of use across multiple platforms. This guide will walk you through the installation process, feature utilization, and provide tips to get the most out of Screencappa.

## Installation Instructions

### Prerequisites
- Administrative privileges on your machine.
- Basic familiarity with command-line operations.

### Dependencies
Before installing Screencappa, ensure the following dependencies are installed:

#### For macOS:
- Qt: `brew install qt`
- OpenCV: `brew install opencv`
- ScreenCaptureKit: `brew install screencapturekit`
- Quartz: `brew install quartz`

#### For Windows:
- Qt5: `vcpkg install qt5`
- OpenCV: `vcpkg install opencv`

### Compiling Screencappa
1. Clone the Screencappa repository:
   ```
   git clone https://github.com/Alabasteropus/Screencappa.git
   ```
2. Navigate to the cloned directory:
   ```
   cd Screencappa
   ```
3. Compile the project using Qt Creator or your preferred IDE that supports Qt and C++.

## Using Screencappa

### Capturing Screenshots
- To capture a screenshot, press the 'Capture' button on the main interface or use the hotkey `Ctrl+Shift+S`.

### Cloning and Cropping
- Select the area of the screen you wish to clone and use the 'Clone' option to create a duplicate.
- Use the 'Crop' feature to trim the screenshot to the desired size.

### Resizing and Repositioning
- Drag the edges of the floating window to resize the cloned capture.
- Click and drag the window to reposition it on your screen.

### Dynamic Resizing and Configurable Cropping
- The captured image can be dynamically resized before processing. To adjust the resolution, navigate to the settings and specify your desired dimensions.
- To set a specific region of interest (ROI) for cropping, use the selection tool to define the area on the captured image.

### Click-through Functionality
- The floating window is click-through by default, allowing you to interact with applications underneath.

## Testing Screencappa

To ensure that Screencappa is functioning correctly on your system, follow these steps:

1. After installation, open Screencappa and attempt to capture a screenshot using the 'Capture' button or the hotkey `Ctrl+Shift+S`.
2. Verify that the screenshot is saved to the specified location and that the image is correct.
3. Test the cloning and cropping features by selecting an area of the screen and using the 'Clone' and 'Crop' options.
4. Resize and reposition the floating window to ensure these functionalities work as expected.
5. Confirm the click-through functionality by attempting to interact with windows or applications behind the floating window.
6. If any issues arise during these tests, refer to the troubleshooting section below or open an issue on the GitHub repository.

## Troubleshooting

If you encounter any issues during installation or usage, please refer to the following tips:

- Ensure all dependencies are correctly installed and up to date.
- Check if your system's firewall or antivirus software is blocking Screencappa.
- For graphical issues, ensure your graphics drivers are updated.

For further assistance, please open an issue on the Screencappa GitHub repository.

Thank you for choosing Screencappa. Happy capturing!
