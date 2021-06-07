import QtQuick 2.15
//import QtQuick.Controls 1.4
import QtQuick.Controls 2.15
//import QtQuick.Window 2.12
//import QtQuick.TreeView 2.15
import TreeModel.com 1.0
import Qt.labs.platform 1.0
import QtQuick.Layouts 1.15
import Qt.labs.qmlmodels 1.0
//import QtQuick.Window 2.2
import Qt.labs.settings 1.0

ApplicationWindow {
    id: windowInstance

    property alias parentOfViews: splitViewInstance
    property alias splitView: splitViewInstance
    property var viewArray: []

    objectName: Math.random().toString(36).substr(2, 5)


    width: 500
    height: 500
    visible: true
    title: qsTr("Node Filter")

    onClosing: {

        for (var i = 0; i < root.array.length; i++) {

            if (windowInstance.objectName.toString(
                        ) === root.array[i].objectName.toString()) {

                root.array.splice(i, 1)
                break
            }
        }
        if (root.array.length === 0) {
            myClass.save()
            Qt.quit()
        }
    }
    MouseArea {
        id: ma
        onClicked: {
            windowInstance.contentItem.childAt(mouseX, mouseY)
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
//            windowInstance.viewArray.push(delegateInstance.createObject(splitViewInstance, {
//                                                                  "test": component
//                                                              })) //
//            splitViewInstance.addItem(ut)

        }
    }
    Shortcut {
        sequence: "Ctrl+Shift+H"
        onActivated: {
            var component = Qt.createComponent("WindowComponent.qml")
            var window = component.createObject(root)
            root.array.push(window)

            window.showMaximized()
            var Randomnumber = Math.random().toString(36).substr(2, 5)
            var component1 = Qt.createQmlObject(
                        "import TreeModel.com 1.0; Filtering { id: car_"
                        + Randomnumber + "; }", window)
            var Randomnumber1 = Math.random().toString(36).substr(2, 5)
            var delegateInstance = Qt.createQmlObject(
                        "Delegate { id: car_" + Randomnumber1 + "; }",
                        window)

            window.viewArray.push(delegateInstance.createObject(
                                      window.splitView, {
                                          "test": component1
                                      }))
        }
    }

    SplitView {
           id: splitViewInstance

           property alias root: windowInstance

           anchors.fill: parent
           orientation: Qt.Horizontal
//
//           Layout.minimumHeight: 200
//                            Layout.preferredHeight: parent.height / 2
//                            Layout.minimumWidth: 100
//                            Layout.preferredWidth: parent.width / 4
//                            Layout.maximumWidth: 1000
           handle : Rectangle {
               implicitWidth: 4
               implicitHeight: 4
               color: SplitHandle.pressed ? "#81e889" : (SplitHandle.hovered ? Qt.lighter(
                                                                                   "#c2f4c6",
                                                                                   1.1) : "#c2f4c6")
           }
           SplitView {
               id: hSplit

   //            Layout.preferredWidth: parent.width / 2
   //            Layout.fillHeight: true
               orientation: Qt.Vertical

               handle : Rectangle {
                   implicitWidth: 4
                   implicitHeight: 4
//                   color: SplitHandle.pressed ? "#81e889" : (SplitHandle.hovered ? Qt.lighter("#c2f4c6", 1.1) : "#c2f4c6")
               }
           }
       }
}
