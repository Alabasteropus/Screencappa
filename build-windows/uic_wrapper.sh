#!/bin/sh
LD_LIBRARY_PATH=/home/ubuntu/qt-everywhere-src-5.15.3/qtbase/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}
export LD_LIBRARY_PATH
QT_PLUGIN_PATH=/home/ubuntu/qt-everywhere-src-5.15.3/qtbase/plugins${QT_PLUGIN_PATH:+:$QT_PLUGIN_PATH}
export QT_PLUGIN_PATH
exec /home/ubuntu/qt-everywhere-src-5.15.3/qtbase/bin/uic "$@"
