#ifndef SCREENCAPTURE_H
#define SCREENCAPTURE_H

#include <QObject>
#include <QPixmap>

class ScreenCapture : public QObject
{
    Q_OBJECT

public:
    explicit ScreenCapture(QObject *parent = nullptr);
    void captureScreen();

signals:
    void captured(QPixmap pixmap);

private:
    // Add private members if needed
};

#endif // SCREENCAPTURE_H
