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
    width: 1280
    height: 1024
    visible: true
    title: qsTr("Hello World")

//    FileDialog {
//        id: openDialog
//        fileMode: FileDialog.OpenFile
//        selectedNameFilter.index: 1
//        nameFilters: ["Text files (*.txt)", "HTML files (*.html *.htm)", "Markdown files (*.md *.markdown)"]
//        folder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
//        onAccepted: document.load(file)
//    }

//    FileDialog {
//        id: saveDialog
//        fileMode: FileDialog.SaveFile
//        defaultSuffix: document.fileType
//        nameFilters: openDialog.nameFilters
//        selectedNameFilter.index: document.fileType === "txt" ? 0 : 1
//        folder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
//        onAccepted: document.saveAs(file)
   // }

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
        SplitView.fillHeight : true
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
        property var parentIndex: myClass.parent(treeview.currentModelIndex)
//       Keys.onDigit9Pressed: {
//                              ld.active = !ld.active
//                          }
        Keys.onDigit3Pressed: {

            event.accepted = true
            var test = parentIndex
            console.log(treeview.currentModelIndex.row)
          myClass.removeRows(treeview.currentModelIndex.row,1,test)//TODO
}
        Keys.onDigit2Pressed: {

            event.accepted = true
            var test = treeview.currentModelIndex
            console.log(test)
          myClass.insertRows(0,1,test)//TODO
}
        Keys.onDigit8Pressed: {

            event.accepted = true
            var test = treeview.currentModelIndex
            console.log(test)
          myClass.saveIndex(test)//TODO
}
        Keys.onDigit5Pressed: {

            event.accepted = true
            var test = treeview.currentModelIndex
            console.log(test)
          //mee.insertRows(0,1,test)//T-ODO
}
        model: myClass




        delegate: Rectangle {

                id:hey
                implicitWidth: 1920
                implicitHeight: 50
                focus:true
                property bool hasChildren: TreeView.hasChildren
                property bool isExpanded: TreeView.isExpanded
                property int depth: TreeView.depth
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
                    text: edit
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
SplitView.fillHeight : true
Shortcut {
    sequence: "Ctrl+E"
    onActivated: myProxy.saveIndex(waaa.currentModelIndex)
}
//SplitView.minimumHeight:200
//implicitHeight: 400
//SplitView.maximumHeight: 600
//        height: 500
        width:100
        styleHints.overlay: "green"
        styleHints.indent: 25
        styleHints.columnPadding: 30



        property var parentIndex: myProxy.parent(waaa.currentModelIndex)
        Keys.onDigit3Pressed: {

            event.accepted = true
            var test = parentIndex
            console.log(waaa.currentModelIndex.row)
          myProxy.removeRows(waaa.currentModelIndex.row,1,test)//TODO
}
        Keys.onDigit2Pressed: {

            event.accepted = true
            var test = waaa.currentModelIndex
            console.log(test)
          myProxy.insertRows(0,1,test)//TODO
}
        Keys.onDigit8Pressed: {

            event.accepted = true
            var test = waaa.currentModelIndex
            console.log(test)
          myProxy.saveIndex(test)//TODO
}
        Keys.onDigit5Pressed: {

            event.accepted = true
            var test = waaa.currentModelIndex
            console.log(test)
          //mee.insertRows(0,1,test)//TODO
}
        model: myProxy



        delegate:




                                        Rectangle {


                                            id:newId
                                            visible:true
                                            implicitHeight: 50
                                            implicitWidth: 1920
                                            focus:true
                                            property bool hasChildren: TreeView.hasChildren
                                            property bool isExpanded: TreeView.isExpanded
                                            property int depth: TreeView.depth

//                                            Component.onCompleted:    {
//                            //                                           var posInTreeView = waaa.mapFromItem(parent, point.position)
//                            //                                           var row = waaa.rowAtY(posInTreeView.y, true)
//                                                   console.log(hasChildren)
//                                                 console.log("uuuuuu  "+ hasChildren)
//                                                if(hasChildren){

//                                                    newId.visible === true
//                                                    console.log("aaaa" + hasChildren)
//                                                }

//                                                                       if (isExpanded == false)
//                                                                           waaa.expand(tap.row) //TODO
//                                                                   }
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

                                                wrapMode:TextEdit.Wrap
                                                textFormat: TextEdit.MarkdownText
                                                clip:true
                                                font.pointSize: 18
                                                x: indicator1.x + Math.max(waaa.styleHints.indent, indicator1.width * 1.5)
                                               text: edit
                                                onEditingFinished: edit = text
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
        waaa.model.setQuery(text)
    }

    }
//    onEditingFinished:

}




}
