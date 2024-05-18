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
            qDebug() << "Screen captured, attempting to process...";

            // Convert QPixmap to QImage then to OpenCV Mat
            QImage originalImage = originalPixmap.toImage();
            cv::Mat originalMat = cv::Mat(originalImage.height(), originalImage.width(),
                                          CV_8UC4, const_cast<uchar*>(originalImage.bits()), originalImage.bytesPerLine());

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

                qDebug() << "Processing complete.";

                // Create a window to display the screenshot
                QWidget window;
                QVBoxLayout *layout = new QVBoxLayout(&window);
                QLabel *imageLabel = new QLabel(&window);
                imageLabel->setPixmap(QPixmap::fromImage(originalImage));
                layout->addWidget(imageLabel);
                window.setLayout(layout);
                window.setWindowTitle("Screen Capture Preview");
                window.setAttribute(Qt::WA_TranslucentBackground); // Make the window background transparent
                window.setAttribute(Qt::WA_TransparentForMouseEvents); // Make the window click-through
                window.show();

            } else {
                qDebug() << "Failed to load screenshot into OpenCV Mat.";
            }
        } else {
            qDebug() << "Failed to capture screen.";
        }
    } else {
        qDebug() << "No primary screen detected.";
    }

    return app.exec();
}
