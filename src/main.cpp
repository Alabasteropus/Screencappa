#include <QApplication>
#include <QWidget>
#include <QScreen>
#include <QPixmap>
#include <QDebug>
#include <opencv2/opencv.hpp>
#include <QLabel>
#include <QVBoxLayout>

int main(int argc, char *argv[]) {
    QApplication app(argc, argv);

    // Capture the screen
    QScreen *primaryScreen = QApplication::primaryScreen();
    if (primaryScreen) {
        qDebug() << "Primary screen detected, attempting to capture...";
        QPixmap originalPixmap = primaryScreen->grabWindow(0);
        if (!originalPixmap.isNull()) {
            qDebug() << "Screen captured, attempting to save...";
            bool saved = originalPixmap.save("/tmp/screenshot.png");
            if (saved) {
                qDebug() << "Screenshot saved successfully to /tmp/screenshot.png";

                // Load the screenshot into an OpenCV Mat
                cv::Mat originalMat = cv::imread("/tmp/screenshot.png");
                if (!originalMat.empty()) {
                    qDebug() << "Screenshot loaded into OpenCV Mat, attempting to clone, crop, resize, and reposition...";

                    // Clone and crop operations
                    cv::Mat clonedMat = originalMat.clone(); // Clone the image
                    cv::Rect roi(10, 10, 100, 100); // Define a region of interest
                    cv::Mat croppedMat = originalMat(roi); // Crop the image

                    // Resize operation
                    cv::Mat resizedMat;
                    cv::resize(originalMat, resizedMat, cv::Size(640, 480), 0, 0, cv::INTER_LINEAR); // Resize the image to 640x480

                    // Reposition operation (translation)
                    cv::Mat repositionedMat;
                    cv::Mat translationMatrix = (cv::Mat_<double>(2,3) << 1, 0, 50, 0, 1, 50); // Translate the image 50 pixels right and down
                    cv::warpAffine(originalMat, repositionedMat, translationMatrix, originalMat.size());

                    // Save the cloned, cropped, resized, and repositioned images
                    cv::imwrite("/tmp/cloned_screenshot.png", clonedMat);
                    cv::imwrite("/tmp/cropped_screenshot.png", croppedMat);
                    cv::imwrite("/tmp/resized_screenshot.png", resizedMat);
                    cv::imwrite("/tmp/repositioned_screenshot.png", repositionedMat);
                    qDebug() << "Cloned, cropped, resized, and repositioned screenshots saved.";

                    // Create a window to display the screenshot
                    QWidget window;
                    QVBoxLayout *layout = new QVBoxLayout(&window);
                    QLabel *imageLabel = new QLabel(&window);
                    imageLabel->setPixmap(QPixmap::fromImage(QImage("/tmp/screenshot.png")));
                    layout->addWidget(imageLabel);
                    window.setLayout(layout);
                    window.setWindowTitle("Screen Capture Preview");
                    window.show();

                } else {
                    qDebug() << "Failed to load screenshot into OpenCV Mat.";
                }
            } else {
                qDebug() << "Failed to save screenshot.";
            }
        } else {
            qDebug() << "Failed to capture screen.";
        }
    } else {
        qDebug() << "No primary screen detected.";
    }

    return app.exec();
}
