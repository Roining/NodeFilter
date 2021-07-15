QT += quick
QT += widgets


CONFIG+=disable-desktop

CONFIG += c++11
#QMAKE_LFLAGS_WINDOWS += --preload-file storage.dat
#QMAKE_LFLAGS_WINDOWS += -s TOTAL_MEMORY=32MB
#QMAKE_CXXFLAGS += NO_EXIT_RUNTIME=1
#CONFIG += debug
#DESTDIR = $$PWD
# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0
TARGET = NodeFilter

    QTPLUGIN += qtvirtualkeyboardplugin
    QT += svg


SOURCES += \
    src/ProxyModel.cpp \
    src/TreeModel.cpp \
    src/TreeNode.cpp \
    src/main.cpp
#QTPLUGIN += C:/Qt/5.15.2/wasm_32/qml/QtQuick/TreeView/libqquicktreeviewplugin.a
#LIBS += C:\Qt\5.15.2\wasm_32\qml\QtQuick\Controls.2\libqtquickcontrols2plugin.a

#QTPLUGIN += QQuickTreeViewPlugin
#LIBS += C:/Qt/5.15.2/wasm_32/qml/QtQuick/TreeView/libqquicktreeviewplugin.a
RESOURCES += \
    qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
#QML_IMPORT_PATH =  C:/Qt/5.15.2/wasm_32/qml
QML_IMPORT_PATH =C:/Qt/5.15.2/wasm_32
# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =
QMAKE_CXXFLAGS += -v
# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    include/ProxyModel.h \
    include/TreeModel.h \
    include/TreeNode.h


DISTFILES += \
    Delegate.qml \
    WindowComponent.qml \
    main.qml

QT_DEBUG_PLUGINS=1
QML_IMPORT_TRACE=1
#QT -= qmltest
##QT.testlib.CONFIG -= console
#/SUBSYSTEM:windows
#/ENTRY:mainCRTStartup
