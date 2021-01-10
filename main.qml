import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.12
import QtQuick.TreeView 2.15
//import TreeModel.com 1.0
//import TreeModel.com1 1.0
import Qt.labs.platform 1.0
import QtQuick.Layouts 1.11
import Qt.labs.qmlmodels 1.0

ApplicationWindow {
    width: 1920
    height: 1024
    visible: true
    title: qsTr("Hello World")

SplitView{
    anchors.fill:parent
    orientation: Qt.Vertical

    handle: Rectangle {
            implicitWidth: 4
            implicitHeight: 4
            color: SplitHandle.pressed ? "#81e889"
                : (SplitHandle.hovered ? Qt.lighter("#c2f4c6", 1.1) : "#c2f4c6")
    }
//    spacing:2
    TreeView {

        id:treeview
//        SplitView.fillHeight : true
        SplitView.preferredHeight:  parent.height/2
//SplitView.minimumHeight:200
//implicitHeight: 400
//SplitView.maximumHeight: 600
//      height: 350
        width:100
//        MouseArea {
//                anchors.fill: parent
//                Keys.onDigit8Pressed: {
//                    ld.active = !ld.active
//                }
//           }
        styleHints.overlay: "green"
        styleHints.indent: 25
        //styleHints.columnPadding: 30
      // anchors.fill: parent //TODO: remove in column view
        property var parentIndex: myProxy.parent(treeview.currentModelIndex)
//       Keys.onDigit9Pressed: {
//                              ld.active = !ld.active
//                          }
        Keys.onDigit3Pressed: {

            event.accepted = true
            var test = parentIndex
            console.log(treeview.currentModelIndex.row)
          myProxy.removeRows(treeview.currentModelIndex.row,1,test)//TODO
}
        Keys.onDigit4Pressed: {

            event.accepted = true
            var test = treeview.currentModelIndex
            console.log(test)
          myProxy.copyRows(0,1,test)//TODO
}
        Keys.onDigit2Pressed: {

            event.accepted = true
            var test = treeview.currentModelIndex
            console.log(test)
          myProxy.insertRows(0,1,test)//TODO
}
        Keys.onDigit8Pressed: {

            event.accepted = true
            var test = treeview.currentModelIndex
            console.log(test)
          myProxy.saveIndex(test)//TODO
}
        Keys.onDigit5Pressed: {

            event.accepted = true
            var test = treeview.currentModelIndex
            console.log(test)
          //mee.insertRows(0,1,test)//T-ODO
}
        model: myProxy



        delegate: Rectangle {
            TapHandler {
                id:tap2
                onTapped: {
                    var posInTreeView = treeview.mapFromItem(parent, point.position)
                    var row = treeview.rowAtY(posInTreeView.y, true)
                    treeview.currentIndex = treeview.viewIndex(0, row);
//                     focus = true
//                                                    if (tapCount == 1)
//                                                        waaa.toggleExpanded(row)
                }
            }

                id:hey
                implicitWidth: 1920
                implicitHeight: 50
                color: "steelblue"
                focus:true
                property bool hasChildren: TreeView.hasChildren
                property bool isExpanded: TreeView.isExpanded
                property int depth: TreeView.depth
//                Component.onCompleted:    {
////                                           var posInTreeView = waaa.mapFromItem(parent, point.position)
////                                           var row = waaa.rowAtY(posInTreeView.y, true)

//                                            myProxy.enableFilter(true)

//                                       }
//                MouseArea {
//                                anchors.fill: parent
//                                onClicked: treeview.currentIndex = index
//                            }
                Keys.onDigit0Pressed: {

                    event.accepted = true
                    var test = treeview.currentIndex
                    console.log(test)
                  // mee.insertRows(0,1,test)//TODO
}
                Keys.onDigit1Pressed: {

                    event.accepted = true
                    var test = treeview.currentModelIndex.row
                    console.log("aaa  " + test)
                   //mee.insertRows(0,1,test)//TODO
}
                Keys.onUpPressed: {

                    event.accepted = true
                   // treeview.currentIndex = treeview.viewIndex;
                    var test = treeview.mapToModel(treeview.index)
                    console.log("aaa " + test)
                   //mee.insertRows(0,1,test)//TODO
}

                Text {
                    id: indicator
                    x: depth * treeview.styleHints.indent

                    color: "black"
                    font: treeview.styleHints.font
                    text: hasChildren ? (isExpanded ? "▼" : "▶") : ""
                    anchors.verticalCenter: parent.verticalCenter


                    TapHandler {
                        onTapped: {
                            var posInTreeView = treeview.mapFromItem(parent, point.position)
                            var row = treeview.rowAtY(posInTreeView.y, true)
                            console.log(row)
                            treeview.currentIndex = treeview.viewIndex(0, row);
                            if (tapCount == 1)
                                treeview.toggleExpanded(row)
                        }
                    }
                }
                Text {
                        id: ball
                        x: depth * treeview.styleHints.indent +indicator.width*1.5
                        color: "black"
                        //anchors.left :  indicator
                        //anchors.leftMargin:100
                        font: treeview.styleHints.font
                        text: "⬤"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                TextArea {

                    focus:true

                    wrapMode:TextEdit.Wrap
                    textFormat: TextEdit.MarkdownText
                    clip:true
                    font.pointSize: 18
                    x: indicator.x + Math.max(treeview.styleHints.indent, indicator.width * 1.5)
                    text: edit //TODO adapt for proxies
                    onEditingFinished: edit = text
                }
        }

    }


//        Loader {
//            id: ld

//            sourceComponent: comp
//            active: false
//            //anchors.fill: parent
//        }

//        Component {
//             id: comp

    TreeView {

        id:waaa
//anchors.top: treeview.bottom
//SplitView.fillHeight : true
        SplitView.preferredHeight:  parent.height/2
Shortcut {
    sequence: "Ctrl+E"
    onActivated: myProxy1.saveIndex(waaa.currentModelIndex)
}
//SplitView.minimumHeight:200
//implicitHeight: 400
//SplitView.maximumHeight: 600
//        height: 500
        width:100
        styleHints.overlay: "green"
        styleHints.indent: 25
        styleHints.columnPadding: 30



        property var parentIndex: myProxy1.parent(waaa.currentModelIndex)
        Keys.onDigit3Pressed: {

            event.accepted = true
            var test = parentIndex
            console.log(waaa.currentModelIndex.row)
          myProxy1.removeRows(waaa.currentModelIndex.row,1,test)//TODO
}
        Keys.onDigit4Pressed: {

            event.accepted = true
            var test = waaa.currentModelIndex
            console.log(test)
          myProxy1.copyRows(0,1,test)//TODO
}
        Keys.onDigit2Pressed: {

            event.accepted = true
            var test = waaa.currentModelIndex.parent
            console.log(test)
          myProxy1.insertRows(waaa.currentModelIndex.row+1,1,test)//TODO
}
        Keys.onDigit8Pressed: {

            event.accepted = true
            var test = waaa.currentModelIndex
            console.log(test)
          myProxy1.saveIndex(test)//TODO
}
        Keys.onDigit5Pressed: {

            event.accepted = true
            var test = waaa.currentModelIndex
            console.log(test)
          myProxy1.insertRows(0,1,test)//TODO
}
        model: myProxy1

        onCurrentIndexChanged: console.log("current index: " + currentIndex
                                               + " current row: " + currentIndex.row)

        delegate:


Component{
            id:ey

                                        Rectangle {

//            MouseArea {
//                    anchors.fill: parent


//                    onClicked: {
//                        console.log(waaa.currentIndex)
//                        focus = true

//                        waaa.currentIndex === index;
//                        console.log(waaa.currentIndex)
//                        console.log(index)

//                        waaa.expand(waaa.currentIndex.row)
//                    }
//                }
                                            TapHandler {
                                                id:tap1
                                                onTapped: {
                                                    var posInTreeView = waaa.mapFromItem(parent, point.position)
                                                    var row = waaa.rowAtY(posInTreeView.y, true)
                                                    waaa.currentIndex = waaa.viewIndex(0, row);
                                                     focus = true
//                                                    if (tapCount == 1)
//                                                        waaa.toggleExpanded(row)
                                                }
                                            }
                                            id:newId
                                            visible:true
                                            implicitHeight: 50
                                            implicitWidth: 1920
//                                            focus:true
                                            property bool hasChildren: TreeView.hasChildren
                                            property bool isExpanded: TreeView.isExpanded
                                            property int depth: TreeView.depth

//                                            Component.onCompleted:    {
                            //                                           var posInTreeView = waaa.mapFromItem(parent, point.position)
                            //                                           var row = waaa.rowAtY(posInTreeView.y, true)

                                                                       // myProxy1.enableFilter(true)
//                                                                       if (isExpanded == false)
//                                                                           waaa.expand(tap.row) //TODO
//                                                                   } //TODO: move to c++?
                                            Keys.onDigit0Pressed: {

                                                event.accepted = true
                                                var test = waaa.currentIndex
                                                console.log(test)
                                              // mee.insertRows(0,1,test)//TODO
                            }
                                            Keys.onDigit1Pressed: {

                                                event.accepted = true
                                                var test = waaa.currentModelIndex.row
                                                console.log("aaa  " + test)
                                               //mee.insertRows(0,1,test)//TODO
                            }
                                            Keys.onUpPressed: {

                                                event.accepted = true
                                               // treeview.currentIndex = treeview.viewIndex;
                                                var test = waaa.mapToModel(waaa.index)
                                                console.log("aaa " + test)
                                               //mee.insertRows(0,1,test)//TODO
                            }

                                            Text {
                                                id: indicator1
                                                x: depth * waaa.styleHints.indent

                                                color: "black"
                                                font: waaa.styleHints.font
                                                text: hasChildren ? (isExpanded ? "▼" : "▶") : ""
                                                anchors.verticalCenter: parent.verticalCenter


                                                TapHandler {
                                                    id:tap
                                                    onTapped: {
                                                        var posInTreeView = waaa.mapFromItem(parent, point.position)
                                                        var row = waaa.rowAtY(posInTreeView.y, true)
                                                        waaa.currentIndex = waaa.viewIndex(0, row);
                                                        if (tapCount == 1)
                                                            waaa.toggleExpanded(row)
                                                    }
                                                }
                                            }
                                            Text {
                                                    id: ball1
                                                    x: depth * waaa.styleHints.indent +indicator1.width*1.5
                                                    color: "black"
                                                   // anchors.left :  indicator1
                                                    anchors.leftMargin:100
                                                    font: waaa.styleHints.font
                                                    text: "⬤"
                                                    anchors.verticalCenter: parent.verticalCenter
                                                }
                                            TextArea {

                                                focus:true
                                                signal qmlSignal(string msg)
                                                wrapMode:TextEdit.Wrap
                                                textFormat: TextEdit.MarkdownText
                                                clip:true
                                                font.pointSize: 18
                                                x: indicator1.x + Math.max(waaa.styleHints.indent, indicator1.width * 1.5)
                                               text: edit
                                                onEditingFinished: {edit = text
                                                qmlSignal ("text");
                                                }
                                                onQmlSignal: {
                                                        console.log(msg)
                                                    }

                                            }
                                   }
    }



}



    TextArea{
    id:search
    signal info(string msg)
    objectName: "search"
//    anchors.top: waaa.bottom
    SplitView.fillHeight : true
    placeholderText: "Search here"
//    SplitView.minimumHeight:200
//   implicitHeight: 400
//    SplitView.maximumHeight: 600

    focus:true
    onTextChanged: {
        //myProxy1.enableFilter(true)
        myProxy1.setBool(true)
        waaa.model.setQuery(text)


    }

    }
//    onEditingFinished:

}




}
