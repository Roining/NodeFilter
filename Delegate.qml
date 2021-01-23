import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.12
import QtQuick.TreeView 2.15
//import TreeModel.com 1.0
//import TreeModel.com1 1.0
import Qt.labs.platform 1.0
import QtQuick.Layouts 1.11
import Qt.labs.qmlmodels 1.0
Component{
    id:tree
    Item{
        id:tee
        property alias test:waaa.model
        SplitView.minimumHeight: 200
        SplitView.preferredHeight:  300
        SplitView.minimumWidth:  100
        SplitView.preferredWidth:  200
        SplitView.maximumWidth:   1920


//    Item{
//        SplitView.preferredHeight:  300

TreeView {
    id:waaa
    width:parent.width
    height:parent.height

Shortcut {
sequence: "Ctrl+E"
onActivated: waaa.model.saveIndex(waaa.currentModelIndex)
}

//    width:100
    styleHints.overlay: "green"
    styleHints.indent: 25
    styleHints.columnPadding: 30



    property var parentIndex: waaa.model.parent(waaa.currentModelIndex)
    Keys.onDigit3Pressed: {

        event.accepted = true
        var test = parentIndex
        console.log("joo" + waaa.currentModelIndex)
     waaa.model.removeRows(waaa.currentModelIndex.row,1,test)//TODO
}
    Keys.onDigit4Pressed: {

        event.accepted = true
        var test = waaa.currentModelIndex
        console.log(test)
      waaa.model.copyRows(0,1,test,myClass.getLastIndex())//TODO
}
    Keys.onDigit7Pressed: {
     waaa.model.log()
    }
    Keys.onDigit6Pressed: {
        //TODO
//        var component = Qt.createQmlObject("import TreeModel.com 1.0; Filtering { id: car_1; }",
//                                                                                           you);
//                                            //        var source1 = source.createObject(you)
//                                                    console.log(waaa.SplitView.preferredHeight)
//                                            waaa.height = waaa.height/2
//                                                    console.log(waaa.SplitView.preferredHeight)
//                                                    var   sprite = trie.createObject(split,{model:component,height:waaa.height})
    }
    Keys.onDigit2Pressed: {

        event.accepted = true
        var test = waaa.currentModelIndex.parent
        console.log(test)
      waaa.model.insertRows(waaa.currentModelIndex.row+1,1,test)//TODO
}
    Keys.onDigit8Pressed: {

        event.accepted = true
        var test = waaa.currentModelIndex
        console.log(test)
      waaa.model.saveIndex(test)//TODO
}
    Keys.onDigit5Pressed: {

        event.accepted = true
       var test = waaa.currentModelIndex
        console.log(test)
      waaa.model.insertRows(0,1,test)//TODO
}
//    model: tee.test

    onCurrentIndexChanged: console.log("current index: " + currentIndex
                                           + " current row: " + currentIndex.row)


    delegate:


Component{
        id:ey

                                    Rectangle {





                                        Shortcut {
                                        sequence: "Ctrl+D"
                                        onActivated:  {
                                            var component = Qt.createQmlObject("import TreeModel.com 1.0; Filtering { id: car_1; }",
                                                                                   you);
                                    //        var source1 = source.createObject(you)

                                            var   sprite = trie.createObject(tes,{model:component})


                                        }
                                        }
//                                        TapHandler {
//                                                                                       id:tap1
//                                                                                       onTapped: {
//                                                                                           var posInTreeView = waaa.mapFromItem(parent, point.position)
//                                                                                           var row = waaa.rowAtY(posInTreeView.y, true)
//                                                                                           waaa.currentIndex = waaa.viewIndex(0, row);
//                                                                                            focus = true
//                                                                                          if (tapCount == 2)
//                                                                                              waaa.toggleExpanded(row)
//                                                                                       }
//                                                                                   }
                                        id:newId
                                        visible:true
                                        implicitHeight: 50
                                        implicitWidth: 1920
                                            focus:true
                                        property bool hasChildren: TreeView.hasChildren
                                        property bool isExpanded: TreeView.isExpanded
                                        property int depth: TreeView.depth






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
                                                    console.log("function row  "+row + "  index row  " + waaa.currentIndex.row )

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
                                            id:content
                                            focus:true

                                            wrapMode:TextEdit.Wrap
                                            textFormat: TextEdit.MarkdownText
                                            clip:true
                                            font.pointSize: 18
                                            x: indicator1.x + Math.max(waaa.styleHints.indent, indicator1.width * 1.5)
                                           text: edit
                                            onTextChanged:  {edit = text

                                            }
                                            Keys.onDigit0Pressed: {

                                                content.text =  waaa.model.getId(waaa.currentModelIndex)
//                                                        textEdit.text = listModel.get(listView.currentIndex).name
                                                content.selectAll()
                                                content.copy()
                                        }
                                            Shortcut {
                                                    sequence: "Ctrl+U"
                                                    onActivated: {
                                                        content.text =  waaa.model.getId(waaa.currentModelIndex)
//                                                        textEdit.text = listModel.get(listView.currentIndex).name
                                                        content.selectAll()
                                                        content.copy()
                                                    }
                                                }


                                        }
                               }
}



}
TextArea{
//    anchors.top:waaa.bottom
id:search
signal info(string msg)
objectName: "search"

SplitView.preferredHeight: 100
placeholderText: "Search here"


//focus:true
onTextChanged: {
    waaa.model.setBool(true)
    waaa.model.setQuery(text)


}

}

}
                }




