import QtQuick 2.15
import QtQuick.Controls 2.15
//import QtQuick.Controls 1.4
import QtQuick.Window 2.12
//import QtQuick.TreeView 2.15
import TreeModel.com 1.0
import Qt.labs.platform 1.0
import QtQuick.Layouts 1.15
import Qt.labs.qmlmodels 1.0
import Qt.labs.settings 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick.VirtualKeyboard 2.15
import QtQuick.VirtualKeyboard.Styles 2.15
import QtQuick.VirtualKeyboard.Settings 2.15

Item{
    id:ur
Component.onCompleted: {
  }
ApplicationWindow {

    id: root
    function isDevice() {
    }
    property var array: []
    property var arrayOfWindows: []

    Component.onDestruction: {

    }
InputPanel {
id: inputPanel
z:1000
y:Qt.inputMethod.visible?parent.height - inputPanel.height -50:parent.height

property int  hidden: parent.height - inputPanel.height -50
width: parent.width
Component.onCompleted: {
if(!sharedModel.isMobile()){
inputPanel.destroy();
}
}
}
onClosing: {



}
    visible: true
    Component.onCompleted: {
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


    Shortcut {
        sequence: "Ctrl+K"
        onActivated: {
            var component = Qt.createComponent("WindowComponent.qml")
            var window = component.createObject(root)
            root.array.push(window)
            window.showMaximized()

        }
    }

}
}
