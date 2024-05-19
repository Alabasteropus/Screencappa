#ifndef IMAGEPROCESSOR_H
#define IMAGEPROCESSOR_H

#include <QObject>
#include <QPixmap>
#include <QRect>

class ImageProcessor : public QObject
{
    Q_OBJECT

public:
    explicit ImageProcessor(QObject *parent = nullptr);

    QPixmap cloneImage(const QPixmap &source);
    QPixmap cropImage(const QPixmap &source, const QRect &rect);
    QPixmap resizeImage(const QPixmap &source, const QSize &size);
    void saveImage(const QPixmap &image, const QString &path);

private:
    // Add private members if needed
};

#endif // IMAGEPROCESSOR_H
