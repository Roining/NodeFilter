
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.12
import QtQuick.TreeView 2.15
import TreeModel.com 1.0
//import TreeModel.com1 1.0
import Qt.labs.platform 1.0
import QtQuick.Layouts 1.11
import Qt.labs.qmlmodels 1.0
import Qt.labs.settings 1.0


ApplicationWindow {
    id:you
    property var array:[]

    property Settings settings:Settings{
        property var arrayOfWindows:[]


    }

visible:false
//property var mainViewArray: [];
Component.onCompleted: {
    var component = Qt.createComponent("WindowComponent.qml");
                   var window    = component.createObject(you);
       window.showMaximized();

}

Component.onDestruction:  {
    for(var i = 0;i<you.array.length;i++){
        settings.arrayOfWindows.push(you.array[i].settings)
    }
//settings.arrayOfWindows = you.array
    console.log("aaaa  "+settings.arrayOfWindows)

}
    Shortcut {
    sequence: "Ctrl+K"
    onActivated:  {
        var component = Qt.createComponent("WindowComponent.qml")

                    var window    = component.createObject(you)
        you.array.push(window)

        window.showMaximized()
//        var Randomnumber = Math.random().toString(36).substr(2, 5);
//        console.log(Randomnumber)
//        var component = Qt.createQmlObject("import TreeModel.com 1.0; Filtering { id: car_" +  Randomnumber + "; }",
//                                               you);
//        var Randomnumber1 = Math.random().toString(36).substr(2, 5);
//        var delegateInstance = Qt.createQmlObject("Window { id: car_" +  Randomnumber1 + "; }",
//                                               you);
//        var   sprite = delegateInstance.createObject(tes,{test:component})

    }
    }




}
