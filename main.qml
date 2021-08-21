import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.12
import QtQuick.TreeView 2.15
import TreeModel.com 1.0
import Qt.labs.platform 1.0
import QtQuick.Layouts 1.11
import Qt.labs.qmlmodels 1.0
import Qt.labs.settings 1.0

ApplicationWindow {
    id: root
Component.onDestruction:  {
            myClass.saveAtExit();

}
    property var array: []
    property var arrayOfWindows: []
    property Settings settings: Settings {
        property var windows: []
    }

    visible: false
    Timer {
          interval: 600000; running: true; repeat: true
          onTriggered:           {
              console.log("saved")
              myClass.save();}

      }
    Component.onCompleted: {
        if (settings.windows.length === 0) {
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
        } else {
            for (var i = 0; i < settings.windows.length; i++) {

                var component = Qt.createComponent("WindowComponent.qml")
                var window = component.createObject(root)
                root.array.push(window)
                window.showMaximized()
                window.x = settings.windows[i][0]
                window.y = settings.windows[i][1]
                window.width = settings.windows[i][2]
                window.height = settings.windows[i][3]

                for (var j = 4; j < settings.windows[i].length; j++) {

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

                var u = 0
                for (var j = 4; j < settings.windows[i].length; j++,u++) {

                    window.viewArray[u].x = settings.windows[i][j][0]
                    window.viewArray[u].y = settings.windows[i][j][1]
                    window.viewArray[u].width = settings.windows[i][j][2]
                    window.viewArray[u].height = settings.windows[i][j][3]
                    window.viewArray[u].ser.append(settings.windows[i][j][4])

                }

            }
        }
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
