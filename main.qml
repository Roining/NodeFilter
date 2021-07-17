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
//import QtQuick.Controls.Styles 1.4
import QtQuick.VirtualKeyboard 2.15
import QtQuick.VirtualKeyboard.Styles 2.15
import QtQuick.VirtualKeyboard.Settings 2.15
import App 1.0

Item{
    id:ur
Component.onCompleted: {
  }
ApplicationWindow {

    id: root
    property alias input: inputPanel
    function isDevice() {
        console.log("pcisDevice4444")

//        return /android|webos|iphone|ipad|ipod|blackberry|iemobile|opera mini|mobile/i.test(navigator.userAgent);
    }
    property var array: []
    property var arrayOfWindows: []
//    property Settings settings: Settings {
//        property var windows: []
//    }
    Component.onDestruction: {
        console.log("destrooooy")

    }
    InputPanel {
        id: inputPanel
//        active:false
        z:1000
        y:Qt.inputMethod.visible?parent.height - inputPanel.height -50:parent.height
//        externalLanguageSwitchEnabled:true
//                y: inputPanel.active? parent.height - inputPanel.height -50:parent.height -50
                property int  hidden: parent.height - inputPanel.height -50
                width: parent.width
//                states: State {
//                    name: "visible"
//                    /*  The visibility of the InputPanel can be bound to the Qt.inputMethod.visible property,
//                        but then the handwriting input panel and the keyboard input panel can be visible
//                        at the same time. Here the visibility is bound to InputPanel.active property instead,
//                        which allows the handwriting panel to control the visibility when necessary.
//                    */
//                    when: inputPanel.active
//                    PropertyChanges {
//                        target: inputPanel
//                        y: parent.height - inputPanel.height -50
//                        opacity: 1
//                                        visible: true
//                    }
//                }
//                State {
//                           name: "hidden"
//                           when: !inputPanel.active
//                           PropertyChanges {
//                               target: inputPanel
//                               y: parent.height
//                               opacity: 0
//                               visible:false
//                           }
//                       }
                             Component.onCompleted: {



if(!myClass.isMobile()){
                                  console.log("non-mobile")

 inputPanel.destroy();
}



                             }

        }


onClosing: {
    console.log("cloooose")
    close.accepted = false
//            onTriggered:  copyDialog1.open();


//    myClass.save()

}
    visible: true
    Component.onCompleted: {

//        if(!root.isDevice()){
//                                          console.log("pc")

////            inputPanel.destroy();
//        }

//        if (settings.windows.length === 0) {

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
//        } else {
//            for (var i = 0; i < settings.windows.length; i++) {

//                var component = Qt.createComponent("WindowComponent.qml")
//                var window = component.createObject(root)
//                root.array.push(window)
//                window.showMaximized()
//                window.x = settings.windows[i][0]
//                window.y = settings.windows[i][1]
//                window.width = settings.windows[i][2]
//                window.height = settings.windows[i][3]

//                for (var j = 4; j < settings.windows[i].length; j++) {

//                    var Randomnumber = Math.random().toString(36).substr(2, 5)
//                    var component1 = Qt.createQmlObject(
//                                "import TreeModel.com 1.0; Filtering { id: car_"
//                                + Randomnumber + "; }", window)
//                    var Randomnumber1 = Math.random().toString(36).substr(2, 5)
//                    var delegateInstance = Qt.createQmlObject(
//                                "Delegate { id: car_" + Randomnumber1 + "; }",
//                                window)

//                    window.viewArray.push(delegateInstance.createObject(
//                                              window.splitView, {
//                                                  "test": component1
//                                              }))
//                }

//                var u = 0
//                for (var j = 4; j < settings.windows[i].length; j++,u++) {

//                    window.viewArray[u].x = settings.windows[i][j][0]
//                    window.viewArray[u].y = settings.windows[i][j][1]
//                    window.viewArray[u].width = settings.windows[i][j][2]
//                    window.viewArray[u].height = settings.windows[i][j][3]
//                    window.viewArray[u].ser.append(settings.windows[i][j][4])

//                }

//            }
//        }
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
//InputPanel {
//        id: inputPanel
//        y: Screen.orientation === Qt.LandscapeOrientation ? parent.height : parent.width + (parent.height-parent.width) / 2
////        y: Qt.inputMethod.visible ? parent.height - inputPanel.height : parent.height

//        anchors.left: parent.left
//        anchors.right: parent.right
//    }
//InputPanel {
//    id: inputPanel
//                z: 89
//                y: yPositionWhenHidden
//                x: Screen.orientation === Qt.LandscapeOrientation ? 0 : (parent.width-parent.height) / 2
//                width: Screen.orientation === Qt.LandscapeOrientation ? parent.width : parent.height

//                keyboard.shadowInputControl.height: (Screen.orientation === Qt.LandscapeOrientation ? parent.height : parent.width) - keyboard.height

//                property real yPositionWhenHidden: Screen.orientation === Qt.LandscapeOrientation ? parent.height : parent.width + (parent.height-parent.width) / 2
//    }


}
