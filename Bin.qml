import QtQuick 2.0

Item {

}
Rectangle {




                Shortcut {
                sequence: "Ctrl+N"
                onActivated:  {
            //        event.accepted = true
                    var test = waaa.currentModelIndex.parent
                    console.log(test)
                  waaa.model.insertRows(waaa.currentModelIndex.row+1,1,test)//TODO


                }
                }
                Shortcut {
                sequence: "Ctrl+D"
                onActivated:  {
                    var component = Qt.createQmlObject("import TreeModel.com 1.0; Filtering { id: car_1; }",
                                                           you);


                    var   sprite = trie.createObject(tes,{model:component})


                }
                }

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

//                                                search.info(waaa.model.getId(waaa.currentModelIndex))
                        waaa.model.getIdToClipboard(waaa.currentModelIndex)
//                                                        textEdit.text = listModel.get(listView.currentIndex).name
//                                                content.selectAll()
//                                                content.copy(waaa.model.getId(waaa.currentModelIndex))
                }
//                                            Shortcut {
//                                                    sequence: "Ctrl+U"
//                                                    onActivated: {
//                                                        content.text =  waaa.model.getId(waaa.currentModelIndex)
////                                                        textEdit.text = listModel.get(listView.currentIndex).name
////                                                        content.selectAll()
////                                                        content.copy()
//                                                    }
//                                                }


                }
       }
Shortcut {
sequence: "Ctrl+H"
onActivated:  {
    var Randomnumber = Math.random().toString(36).substr(2, 5);
    console.log(Randomnumber)
//        var tes1 = "import TreeModel.com 1.0; Filtering { id: car_; }";

    var component = Qt.createQmlObject("import TreeModel.com 1.0; Filtering { id: car_" +  Randomnumber + "; }",
                                           you);
//        var source1 = source.createObject(you)

//        var   sprite = trie.createObject(tes,{test:component})
    var Randomnumber1 = Math.random().toString(36).substr(2, 5);
    var delegateInstance = Qt.createQmlObject("Delegate { id: car_" +  Randomnumber1 + "; }",
                                           you);
    var   sprite = delegateInstance.createObject(tes,{test:component})

}
}
Shortcut {
sequence: "Alt+V"
       context: Qt.ApplicationShortcut
onActivated: {

tee.destroy();
    console.log("ghjgjjh")
}
}
//    Keys.onPressed: {
//     if((event.key == Qt.Key_P)&&(event.modifiers &Qt.ControlModifier) &&(event.modifiers &Qt.ShiftModifier)){
//           waaa.model.acceptsCopies(waaa.currentModelIndex,false)
//     }
//     }
//    Keys.onPressed: {
//     if((event.key == Qt.Key_N)&&(event.modifiers &Qt.ControlModifier) &&(event.modifiers &Qt.ShiftModifier)){
//         var test = waaa.currentModelIndex
//          console.log(test)
//        waaa.model.insertRows(0,1,test)//TODO
// //         waaa.expand(test.row);
//     }
//     }
//    Keys.onPressed: {
//     if((event.key == Qt.Key_S)&&(event.modifiers &Qt.ControlModifier)){
//         waaa.model.log()
//     }
//     }
//    Keys.onPressed: {
//     if((event.key == Qt.Key_D)&&(event.modifiers &Qt.ControlModifier)){
//         var test = waaa.model.parent(waaa.currentModelIndex)
//                 console.log("joo" + waaa.currentModelIndex)
//              waaa.model.removeRows(waaa.currentModelIndex.row,1,test)//TODO
//         }
//     }

//    Keys.onPressed: {
//     if((event.key == Qt.Key_A)&&(event.modifiers &Qt.ControlModifier)){

//         var test = waaa.currentModelIndex
//                 console.log(test)
//               waaa.model.saveIndex(test)//TODO
//     }
//     }
//    Keys.onPressed: {
//     if((event.key == Qt.Key_E)&&(event.modifiers &Qt.ControlModifier)){
//        waaa.model.getIdToClipboard(waaa.currentModelIndex)
//     }
//     }
//    Keys.onPressed: {
//     if((event.key == Qt.Key_F)&&(event.modifiers &Qt.ControlModifier)){
//         search.focus = true

//     }
//     }
//    Keys.onPressed: { //close the view
//     if((event.key == Qt.Key_D)&&(event.modifiers &Qt.AltModifier)){
//        tee.destroy();
//     }
//     }
//    Keys.onPressed: { //copy rows
//    if((event.key == Qt.Key_M)&&(event.modifiers &Qt.ControlModifier)){
//        var test = waaa.currentModelIndex
//                console.log(test)
//              waaa.model.copyRows(0,1,test,myClass.getLastIndex())//TODO
//    }
//    }
//    Keys.onPressed: {//copy rows as child
//     if((event.key == Qt.Key_M)&&(event.modifiers &Qt.ControlModifier)&&(event.modifiers &Qt.ShiftModifier)){
//         event.accepted = true
//             var test = waaa.currentModelIndex
//             console.log(test)
//           waaa.model.copyRows(0,1,test,myClass.getLastIndex())//TODO
//     }
//     }

//    Keys.onPressed: {
//    if((event.key == Qt.Key_N)&&(event.modifiers &Qt.ControlModifier)){
//        var test = waaa.currentModelIndex.parent
//        console.log(test)
//      waaa.model.insertRows(waaa.currentModelIndex.row,1,test)//TODO
//    }
//    }
