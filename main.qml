
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.12
import QtQuick.TreeView 2.15
import TreeModel.com 1.0
//import TreeModel.com1 1.0
import Qt.labs.platform 1.0
import QtQuick.Layouts 1.11
import Qt.labs.qmlmodels 1.0


ApplicationWindow {
    id:you
property var arrayOfViews
    MouseArea{
            id: ma
            anchors.fill: parent
            onClicked: {
               you.contentItem.childAt(mouseX, mouseY)
                console.log(you.contentItem.childAt(mouseX, mouseY))
            }
        }
property var viewArray: [];
    Component.onCompleted:{
            var Randomnumber = Math.random().toString(36).substr(2, 5);
            console.log(Randomnumber)
            var component = Qt.createQmlObject("import TreeModel.com 1.0; Filtering { id: car_" +  Randomnumber + "; }",
                                                   you);
            var Randomnumber1 = Math.random().toString(36).substr(2, 5);
            var delegateInstance = Qt.createQmlObject("Delegate { id: car_" +  Randomnumber1 + "; }",
                                                   you);
            var   sprite = delegateInstance.createObject(tes,{test:component})

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
    function getRandomArbitrary(min, max) {
        return Math.random() * (max - min) + min;
    }
    Shortcut {
    sequence: "Ctrl+Shift+F"
    onActivated:  {
//        var Randomnumber = Math.random().toString(36).substr(2, 5);
        var Randomnumber = Math.random().toString(36).substr(2, 5);

        console.log(Randomnumber)
        var component = Qt.createQmlObject("import TreeModel.com 1.0; Filtering { id: car_" +  Randomnumber + "; }",
                                               you);
        var Randomnumber1 = Math.random().toString(36).substr(2, 5);
        var delegateInstance = Qt.createQmlObject("SearchProxy { id: car_" +  Randomnumber1 + "; }",
                                               you);
        var   sprite = delegateInstance.createObject(tes,{test:component})


    }
    }

    Shortcut {
    sequence: "Ctrl+T"
    onActivated:  {
        var Randomnumber = Math.random().toString(36).substr(2, 5);
        console.log(Randomnumber)
        var component = Qt.createQmlObject("import TreeModel.com 1.0; Filtering { id: car_" +  Randomnumber + "; }",
                                               you);
        var Randomnumber1 = Math.random().toString(36).substr(2, 5);
        var delegateInstance = Qt.createQmlObject("Delegate { id: car_" +  Randomnumber1 + "; }",
                                               you);
        var   sprite = delegateInstance.createObject(tes,{test:component})
//        sprite.focus === true;

    }
    }
    Shortcut {
    sequence: "Ctrl+K"
    onActivated:  {
        var component = Qt.createComponent("Window.qml")
                    var window    = component.createObject(you)
                    window.show()
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

//    Shortcut {
//    sequence: "Ctrl+"
//    onActivated:  {
//        var Randomnumber = Math.random().toString(36).substr(2, 5);
//        console.log(Randomnumber)
//        var component = Qt.createQmlObject("import TreeModel.com 1.0; Filtering { id: car_" +  Randomnumber + "; }",
//                                               you);
//        var Randomnumber1 = Math.random().toString(36).substr(2, 5);
//        var delegateInstance = Qt.createQmlObject("Delegate { id: car_" +  Randomnumber1 + "; }",
//                                               you);
//        var   sprite = delegateInstance.createObject(split,{test:component})

//    }
//    }
    onClosing: {
        myClass.log()
    }
    width: 1920
    height: 1024
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
