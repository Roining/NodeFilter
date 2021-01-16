
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
    SearchProxy{
    id:find
    }
    Shortcut {
    sequence: "Ctrl+F"
    onActivated:  {
        var component = Qt.createQmlObject("import TreeModel.com 1.0; Filtering { id: car_1; }",
                                               you);
//        var source1 = source.createObject(you)

        var   sprite = find.createObject(tes,{test:component})


    }
    }
    Shortcut {
    sequence: "Ctrl+M"
    onActivated:  {
        var component = Qt.createQmlObject("import TreeModel.com 1.0; Filtering { id: car_1; }",
                                               you);
//        var source1 = source.createObject(you)

        var   sprite = find.createObject(tes,{test:myClass})


    }
    }
    Shortcut {
    sequence: "Ctrl+V"
    onActivated:  {
        var component = Qt.createQmlObject("import TreeModel.com 1.0; Filtering { id: car_1; }",
                                               you);
//        var source1 = source.createObject(you)

        var   sprite = trie.createObject(split,{test:component})


    }
    }
    Shortcut {
    sequence: "Ctrl+H"
    onActivated:  {
        var component = Qt.createQmlObject("import TreeModel.com 1.0; Filtering { id: car_1; }",
                                               you);
//        var source1 = source.createObject(you)

        var   sprite = trie.createObject(tes,{test:component})


    }
    }
    width: 1920
    height: 1024
    visible: true
    title: qsTr("Hello World")
    Filtering{
    id:source
    }
    Delegate{
        id:trie

    }

SplitView{
    id:split

    anchors.fill:parent
    orientation: Qt.Vertical

    handle: Rectangle {
            implicitWidth: 4
            implicitHeight: 4
            color: SplitHandle.pressed ? "#81e889"
                : (SplitHandle.hovered ? Qt.lighter("#c2f4c6", 1.1) : "#c2f4c6")
    }



}


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
}


}
