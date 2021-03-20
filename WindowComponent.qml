import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.12
import QtQuick.TreeView 2.15
import TreeModel.com 1.0
import Qt.labs.platform 1.0
import QtQuick.Layouts 1.11
import Qt.labs.qmlmodels 1.0
import QtQuick.Window 2.2
import Qt.labs.settings 1.0

ApplicationWindow {
    id: windowInstance

    property alias parentOfViews: splitViewInstance
    property alias splitView: splitViewInstance
    property var viewArray: []

    objectName: Math.random().toString(36).substr(2, 5)


    width: Screen.width
    height: Screen.height
    visible: true
    title: qsTr("Node Filter")
    Component.onCompleted: {

        //            var Randomnumber = Math.random().toString(36).substr(2, 5);
        //            console.log(Randomnumber)
        //            var component = Qt.createQmlObject("import TreeModel.com 1.0; Filtering { id: car_; }",
        //                                                   you1);
        //            var Randomnumber1 = Math.random().toString(36).substr(2, 5);
        //            var delegateInstance = Qt.createQmlObject("Delegate { id: car_ ; }",
        //                                                   you1);
        ////            var   sprite = delegateInstance.createObject(tes,{test:component})
        ////        you.viewArray.push(sprite)

        //        you1.viewArray.push(delegateInstance.createObject(tes,{test:component}))
    }
    onClosing: {

        for (var i = 0; i < you.array.length; i++) {
            console.log("[ii]  " + you.array[i].objectName.toString())

            console.log("yyyy  " + windowInstance.objectName.toString())
            if (windowInstance.objectName.toString(
                        ) === you.array[i].objectName.toString()) {
                console.log("brrrrr  ")

                you.array.splice(i, 1)
                break
            }
        }
        if (you.array.length === 0) {
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

    SearchProxy {
        id: find
    }
    Filtering {
        id: source
    }
    Delegate {
        id: nodeDelegate
    }

    Shortcut {
        sequence: "Ctrl+Shift+F"
        onActivated: {
            var Randomnumber = Math.random().toString(36).substr(2, 5)

            console.log(Randomnumber)
            var component = Qt.createQmlObject(
                        "import TreeModel.com 1.0; Filtering { id: car_" + Randomnumber + "; }",
                        windowInstance)
            var Randomnumber1 = Math.random().toString(36).substr(2, 5)
            var delegateInstance = Qt.createQmlObject(
                        "SearchProxy { id: car_" + Randomnumber1 + "; }", windowInstance)
            windowInstance.viewArray.push(delegateInstance.createObject(splitViewInstance, {
                                                                  "test": component
                                                              }))
        }
    }

    Shortcut {
        sequence: "Ctrl+T"
        onActivated: {
            var Randomnumber = Math.random().toString(36).substr(2, 5)
            console.log(Randomnumber)
            var component = Qt.createQmlObject(
                        "import TreeModel.com 1.0; Filtering { id: car_" + Randomnumber + "; }",
                        windowInstance)
            var Randomnumber1 = Math.random().toString(36).substr(2, 5)
            var delegateInstance = Qt.createQmlObject(
                        "Delegate { id: car_" + Randomnumber1 + "; }", windowInstance)
            windowInstance.viewArray.push(delegateInstance.createObject(splitViewInstance, {
                                                                  "test": component
                                                              }))
        }
    }
    Shortcut {
        sequence: "Ctrl+K"
        onActivated: {
            var component = Qt.createComponent("WindowComponent.qml")
            var window = component.createObject(you)
            you.array.push(window)

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
        handle: Rectangle {
            implicitWidth: 4
            implicitHeight: 4
            color: SplitHandle.pressed ? "#81e889" : (SplitHandle.hovered ? Qt.lighter(
                                                                                "#c2f4c6",
                                                                                1.1) : "#c2f4c6")
        }
        SplitView {
            id: hSplit

            Layout.preferredWidth: parent.width / 2
            Layout.fillHeight: true
            orientation: Qt.Vertical

            handle: Rectangle {
                implicitWidth: 4
                implicitHeight: 4
                color: SplitHandle.pressed ? "#81e889" : (SplitHandle.hovered ? Qt.lighter("#c2f4c6", 1.1) : "#c2f4c6")
            }
        }
    }
}
