#include <QApplication>
#include <QWidget>
#include <QScreen>
#include <QPixmap>
#include <QDebug>
#include <opencv2/opencv.hpp>
#include <QLabel>
#include <QVBoxLayout>

/**
 * @file main.cpp
 * @brief This file contains the main application logic for the Screencappa tool.
 *        It captures the screen, processes the image using OpenCV, and displays
 *        it in a Qt window with click-through functionality.
 */

/**
 * @brief Captures the screen and returns the captured image as a QPixmap.
 *        If no primary screen is detected or the screen capture fails, an empty QPixmap is returned.
 *
 * @return QPixmap containing the captured screen image or an empty QPixmap if capture fails.
 */
QPixmap captureScreen() {
    // Capture the screen
    QScreen *primaryScreen = QApplication::primaryScreen();
    if (primaryScreen) {
        qDebug() << "Primary screen detected, attempting to capture...";
        QPixmap originalPixmap = primaryScreen->grabWindow(0);
        if (!originalPixmap.isNull()) {
            qDebug() << "Screen captured.";
            return originalPixmap;
        } else {
            qDebug() << "Failed to capture screen. Returning an empty QPixmap.";
        }
    } else {
        qDebug() << "No primary screen detected. Returning an empty QPixmap.";
    }
    return QPixmap();
}

/**
 * @brief Processes the captured image using OpenCV for cropping and repositioning.
 *        The function converts the QPixmap to a QImage, then to an OpenCV Mat for processing.
 *        Cropping is performed based on a predefined region of interest (ROI).
 *        The image is then repositioned using a translation matrix.
 *        If the input QPixmap is empty, an empty cv::Mat is returned.
 *
 * @param originalPixmap The original QPixmap captured from the screen.
 * @return cv::Mat containing the processed image or an empty cv::Mat if input is empty.
 */
cv::Mat processImage(const QPixmap &originalPixmap) {
    // Convert QPixmap to QImage then to OpenCV Mat
    QImage originalImage = originalPixmap.toImage();
    cv::Mat originalMat = cv::Mat(originalImage.height(), originalImage.width(),
                                  CV_8UC4, const_cast<uchar*>(originalImage.bits()), originalImage.bytesPerLine());

    if (!originalMat.empty()) {
        qDebug() << "Screenshot loaded into OpenCV Mat, attempting to crop and reposition...";

        // Crop operation
        // Define a region of interest for cropping the image
        // The region is defined by the top-left corner (x, y) and the width and height of the region
        static cv::Rect roi(10, 10, 100, 100); // Made static to avoid redefinition if ROI doesn't change often
        cv::Mat croppedMat = originalMat(roi); // Crop the image based on the region of interest

        // Reposition operation (translation)
        // Translate the image 50 pixels to the right and 50 pixels down
        // This is achieved by creating a transformation matrix and applying it to the cropped image
        cv::Mat repositionedMat;
        cv::Mat translationMatrix = (cv::Mat_<double>(2,3) << 1, 0, 50, 0, 1, 50);
        cv::warpAffine(croppedMat, repositionedMat, translationMatrix, croppedMat.size());

        qDebug() << "Processing complete.";
        return repositionedMat;
    } else {
        qDebug() << "Input QPixmap is empty. Returning an empty cv::Mat.";
        return cv::Mat();
    }
}

/**
 * @brief Sets up the user interface to display the processed image.
 *        A QLabel is used to display the image within a QVBoxLayout.
 *        The window is configured to be transparent and click-through.
 *        If the input cv::Mat is empty, the UI setup is skipped.
 *
 * @param processedImage The processed image to display in the UI.
 */
void setupUI(const cv::Mat &processedImage) {
    if (!processedImage.empty()) {
        // Create a window to display the screenshot
        QWidget window;
        QVBoxLayout *layout = new QVBoxLayout(&window);
        QLabel *imageLabel = new QLabel(&window);
        imageLabel->setPixmap(QPixmap::fromImage(QImage(processedImage.data, processedImage.cols, processedImage.rows, processedImage.step, QImage::Format_ARGB32)));
        layout->addWidget(imageLabel);
        window.setLayout(layout);
        window.setWindowTitle("Screen Capture Preview");
        window.setAttribute(Qt::WA_TranslucentBackground); // Make the window background transparent
        window.setAttribute(Qt::WA_TransparentForMouseEvents); // Make the window click-through
        window.show();
    } else {
        qDebug() << "Input cv::Mat is empty. UI setup skipped.";
    }
}

int main(int argc, char *argv[]) {
    QApplication app(argc, argv);

    QPixmap originalPixmap = captureScreen();
    if (!originalPixmap.isNull()) {
        cv::Mat processedImage = processImage(originalPixmap);
        setupUI(processedImage);
    } else {
        qDebug() << "Failed to capture screen. Application will exit.";
        return -1;
    }

    return app.exec();
}
