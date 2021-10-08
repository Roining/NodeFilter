import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.12
import TreeModel.com 1.0
import Qt.labs.platform 1.0
import QtQuick.Layouts 1.15
import Qt.labs.qmlmodels 1.0
import Qt.labs.settings 1.0

ApplicationWindow {
    id: windowInstance
function newPane(){
    var Randomnumber = Math.random().toString(36).substr(2, 5)
    var component = Qt.createQmlObject(
                "import TreeModel.com 1.0; Filtering { id: car_" + Randomnumber + "; }",
                windowInstance)
    var Randomnumber1 = Math.random().toString(36).substr(2, 5)
    var delegateInstance = Qt.createQmlObject(
                "Delegate { id: car_" + Randomnumber1 + "; }", windowInstance)

    var ut = delegateInstance.createObject(splitViewInstance, {
                                               "test": component
                                           })
}
    property alias parentOfViews: splitViewInstance
    property alias splitView: splitViewInstance
    property var viewArray: []

    objectName: Math.random().toString(36).substr(2, 5)

    width: Screen.width
        height: Screen.height
    visible: true
    title: qsTr("Node Filter")

    onClosing: {


close.accepted = false
            sharedModel.save()

    }
    MouseArea {
        id: ma
        onClicked: {
            windowInstance.contentItem.childAt(mouseX, mouseY)
        }
    }
    Shortcut {
        sequence: "Ctrl+Shift+O"
        onActivated: {

sharedModel.loadFileIDBFS();
        }
    }

    Shortcut {
        sequence: "Ctrl+Shift+S"
        onActivated: {

sharedModel.saveIDBFS();
        }
    }

    Shortcut {
        sequence: "Ctrl+Shift+X"
        onActivated: {


        }
    }

    Shortcut {
        sequence: "Ctrl+Shift+J"
        onActivated: {

        }
    }
    Shortcut {
        sequence: "Ctrl+Shift+Y"
        onActivated: {
            var Randomnumber = Math.random().toString(36).substr(2, 5)
            var component = Qt.createQmlObject(
                        "import TreeModel.com 1.0; Filtering { id: car_" + Randomnumber + "; }",
                        windowInstance)
            var Randomnumber1 = Math.random().toString(36).substr(2, 5)
            var delegateInstance = Qt.createQmlObject(
                        "Delegate { id: car_" + Randomnumber1 + "; }", windowInstance)

            var ut = delegateInstance.createObject(splitViewInstance, {
                                                       "test": component
                                                   })

        }
    }

    SplitView {
           id: splitViewInstance

           property alias root: windowInstance

           anchors.fill: parent
           orientation: Qt.Horizontal
           handle : Rectangle {
               implicitWidth: 4
               implicitHeight: 1
               color: SplitHandle.pressed ? "#81e889" : (SplitHandle.hovered ? Qt.lighter(
                                                                                   "#c2f4c6",
                                                                                   1.1) : "#c2f4c6")
           }
           SplitView {
               id: hSplit
               orientation: Qt.Vertical

               handle : Rectangle {
                   implicitWidth: 4
                   implicitHeight: 4
               }
           }
       }

}

