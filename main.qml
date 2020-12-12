import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.12
import QtQuick.TreeView 2.15
import TreeModel.com 1.0
import Qt.labs.platform 1.0
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

    TreeView {
        id:treeview
        styleHints.overlay: "green"
        styleHints.indent: 25
        styleHints.columnPadding: 30
        anchors.fill:parent
        property var parentIndex: mee.parent(treeview.currentModelIndex)
        Keys.onDigit3Pressed: {

            event.accepted = true
            var test = parentIndex
            console.log(treeview.currentModelIndex.row)
          mee.removeRows(treeview.currentModelIndex.row,1,test)//TODO
}
        Keys.onDigit2Pressed: {

            event.accepted = true
            var test = treeview.currentModelIndex
            console.log(test)
          mee.insertRows(0,1,test)//TODO
}
        Keys.onDigit5Pressed: {

            event.accepted = true
            var test = treeview.currentModelIndex
            console.log(test)
          //mee.insertRows(0,1,test)//TODO
}
        model: TreeModel{
            id:mee
        }




        delegate: Rectangle {

                id:hey
                implicitWidth: 1920
                implicitHeight: 50
                focus:true
                property bool hasChildren: TreeView.hasChildren
                property bool isExpanded: TreeView.isExpanded
                property int depth: TreeView.depth

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
                    text: display
                }
        }

    }


}
//    Rectangle {
//            implicitWidth: 500
//            SplitView.maximumWidth: 900
//            color: "lightblue"
//            Label {
//                text: "View 1"
//                anchors.centerIn: parent
//            }
//        }


