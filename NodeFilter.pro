QT += quick
CONFIG += c++11



# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0
TARGET = NodeFilter

SOURCES += \
    src/ProxyModel.cpp \
    src/TreeModel.cpp \
    src/TreeNode.cpp \
    src/main.cpp

RC_ICONS += /resources/icon.ico

RESOURCES += \
    qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

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
    main.qml \
    resources/icon.ico
#QT -= qmltest
##QT.testlib.CONFIG -= console
#/SUBSYSTEM:windows
#/ENTRY:mainCRTStartup
