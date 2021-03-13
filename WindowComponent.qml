
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.12
import QtQuick.TreeView 2.15
import TreeModel.com 1.0
//import TreeModel.com1 1.0
import Qt.labs.platform 1.0
import QtQuick.Layouts 1.11
import Qt.labs.qmlmodels 1.0
import QtQuick.Window 2.2
import Qt.labs.settings 1.0

ApplicationWindow {
    id:you1
    objectName: Math.random().toString(36).substr(2, 5);
//    transientParent: null
//    visibility: "FullScreen"
property var arrayOfViews:[]
   property Settings settings: Settings{
//        property alias objectName: you1.objectName

        property alias width:you1.width
        property alias height:you1.height
        property alias x:you1.x
        property alias y:you1.y

    }
    MouseArea{
            id: ma
//            anchors.fill: parent
            onClicked: {
               you1.contentItem.childAt(mouseX, mouseY)
                console.log(you1.contentItem.childAt(mouseX, mouseY))
            }
        }
property var viewArray: [];
    Component.onCompleted:{
            var Randomnumber = Math.random().toString(36).substr(2, 5);
            console.log(Randomnumber)
            var component = Qt.createQmlObject("import TreeModel.com 1.0; Filtering { id: car_; }",
                                                   you1);
            var Randomnumber1 = Math.random().toString(36).substr(2, 5);
            var delegateInstance = Qt.createQmlObject("Delegate { id: car_ ; }",
                                                   you1);
//            var   sprite = delegateInstance.createObject(tes,{test:component})
//        you.viewArray.push(sprite)

        you1.viewArray.push(delegateInstance.createObject(tes,{test:component}))

    }

    SearchProxy{
    id:find
    }
    Filtering{
    id:source
    }
    Delegate{
        id:trie

    }

    Shortcut {
    sequence: "Ctrl+Shift+F"
    onActivated:  {
//        var Randomnumber = Math.random().toString(36).substr(2, 5);
        var Randomnumber = Math.random().toString(36).substr(2, 5);

        console.log(Randomnumber)
        var component = Qt.createQmlObject("import TreeModel.com 1.0; Filtering { id: car_" +  Randomnumber + "; }",
                                               you1);
        var Randomnumber1 = Math.random().toString(36).substr(2, 5);
        var delegateInstance = Qt.createQmlObject("SearchProxy { id: car_" +  Randomnumber1 + "; }",
                                               you1);
//        var   sprite = delegateInstance.createObject(tes,{test:component})
you1.viewArray.push(delegateInstance.createObject(tes,{test:component}))

    }
    }

    Shortcut {
    sequence: "Ctrl+T"
    onActivated:  {
        var Randomnumber = Math.random().toString(36).substr(2, 5);
        console.log(Randomnumber)
        var component = Qt.createQmlObject("import TreeModel.com 1.0; Filtering { id: car_" +  Randomnumber + "; }",
                                               you1);
        var Randomnumber1 = Math.random().toString(36).substr(2, 5);
        var delegateInstance = Qt.createQmlObject("Delegate { id: car_" +  Randomnumber1 + "; }",
                                               you1);
//        var   sprite = delegateInstance.createObject(tes,{test:component})
//        sprite.focus === true;
        you1.viewArray.push(delegateInstance.createObject(tes,{test:component}))

    }
    }
    Shortcut {
    sequence: "Ctrl+K"
    onActivated:  {
        var component = Qt.createComponent("WindowComponent.qml")
                    var window    = component.createObject(you)
        you.array.push(window)

        window.showMaximized()
    }
    }


    onClosing: {
//        console.log("yyyy  "+you.array)

for(var i =0;i<you.array.length;i++){
    console.log("[ii]  "+you.array[i].objectName.toString())

console.log("yyyy  "+you1.objectName.toString())
if(you1.objectName.toString() ==you.array[i].objectName.toString()){
    console.log("brrrrr  ")

    you.array.splice(i,1);
break;
}
}
if(you.array.length ===0){
        myClass.log()
        Qt.quit()
}

    }

width:Screen.width
    height: Screen.height
    visible: true
    title: qsTr("Hello World")




SplitView{
anchors.fill:parent
id:tes
orientation: Qt.Horizontal
handle: Rectangle {
        implicitWidth: 4
        implicitHeight: 4
        color: SplitHandle.pressed ? "#81e889"
            : (SplitHandle.hovered ? Qt.lighter("#c2f4c6", 1.1) : "#c2f4c6")
}
SplitView{
    id:split

    Layout.preferredWidth: parent.width / 2
            Layout.fillHeight: true
    orientation: Qt.Vertical

    handle: Rectangle {
            implicitWidth: 4
            implicitHeight: 4
            color: SplitHandle.pressed ? "#81e889"
                : (SplitHandle.hovered ? Qt.lighter("#c2f4c6", 1.1) : "#c2f4c6")
    }



}
}



}
