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


//    Keys.onDigit4Pressed: {

//        event.accepted = true
//        var test = waaa.currentModelIndex.parent
//        console.log(test)
//      waaa.model.copyRows(waaa.currentModelIndex.row,1,test,myClass.getLastIndex())//TODO
//}
//    Keys.onDigit5Pressed: {

////                                                event.accepted = true
//       var test = waaa.currentModelIndex
//        console.log(test)
//      waaa.model.insertRows(0,1,test)//TODO

////        waaa.expand(waaa.currentModelIndex.row);
//}
//    Keys.onDigit9Pressed: {

//        event.accepted = true
//        var test = waaa.currentModelIndex
//        console.log(test)
//      waaa.model.copyRows(0,1,test,myClass.getLastIndex())//TODO
//}
//    Keys.onDigit6Pressed: {
//    search.focus = true
//    }
//    Keys.onDigit7Pressed: {
//     waaa.model.log()
//    }

//    Keys.onDigit1Pressed: {

//        tee.destroy();
//}
//    Keys.onDigit3Pressed: {

//        var test = waaa.model.parent(waaa.currentModelIndex)
//        console.log("joo" + waaa.currentModelIndex)
//     waaa.model.removeRows(waaa.currentModelIndex.row,1,test)//TODO
//}
//    Keys.onDigit2Pressed: {

//        event.accepted = true
//        var test = waaa.currentModelIndex.parent
//        console.log(test)
//      waaa.model.insertRows(waaa.currentModelIndex.row,1,test)//TODO
//}
//    Keys.onDigit8Pressed: {

//        event.accepted = true
//        var test = waaa.currentModelIndex
//        console.log(test)
//      waaa.model.saveIndex(test)//TODO
//}

//    model: tee.test
//                                        Shortcut {
//                                        sequence: "Ctrl+D"
//                                        onActivated:  {
//                                            var component = Qt.createQmlObject("import TreeModel.com 1.0; Filtering { id: car_1; }",
//                                                                                   you);
//                                    //        var source1 = source.createObject(you)

//                                            var   sprite = trie.createObject(tes,{model:component})


//                                        }
//                                        }
//onChange: waaa.forceLayout();
rowHeightProvider: function(row){
//    console.log("row " + row);
//    for (var i = 0; i < waaa.count; i ++) {
//         // this will get list item at index i
//         console.log(waaa.contentItem.children[i]);

//         // lets set it height to 100
//         waaa.contentItem.children[i].height=100;
//      }
//    for(var i =0;i<30;i++ ){
//        if(waaa.contentItem.children[i].conHeight){
//        console.log("index.row " + i + "  " + waaa.contentItem.children[i].conHeight);
//        }
//    }


//    console.log("index " + waaa.contentItem.children[row]);
//    console.log("row " + row);
//    var array = [];
//    for(var child in waaa.contentItem.children) {
//        var o = waaa.contentItem.children[child].toString();

//if(waaa.contentItem.children[i].conHeight){
//           array.push(waaa.contentItem.children[child].conHeight)}
//    }
//        for(var i =0;i<waaa.contentItem.children.;i++ ){
//            if(waaa.contentItem.children[i].conHeight){
//                  console.log("index.row " + waaa.contentItem.children[row].conHeight);
//                array.push(waaa.contentItem.children[i].conHeight)
////                 console.log("index.row after " + array);
//            }
//        }

console.log("index.row after " + array);
//    console.log("count " + waaa.count);



//    waaa.contentItem.children[row].content.height
//    return waaa.contentItem.children[row].content.height}
//    return waaa.contentItem.children[row].conHeight}

        console.log("array " + array[row]);
//        console.log("row " + row);
        return waaa.contentItem.children[row].conHeight
    }
//    Keys.onDigit2Pressed: {
//        waaa.forceLayout();


//}
//Timer{
//running:true
//interval:200

//onTriggered:{
////waaa.rowHeight = content.height;
//    waaa.forceLayout();
//    console.log("rowHeightProvider " + waaa.rowHeightProvider )
//    console.log("content.height " + content.height )

//}

//}
Q_INVOKABLE bool TreeModel::removeRows(int position, int rows, const QModelIndex &parent)
{
    TreeItem *parentItem = getItem(parent);
    if (!parentItem){
        return false;}
     const QModelIndex &child  = this->index(position, 0, parent);

     removeRows1( position,0,parentItem->id,child);

//    if(!parentItem->parents.isEmpty()){
//   //        QVector<QUuid> siblingCopy = (item->parents);
//   //        siblingCopy.erase(std::find( siblingCopy.begin(),  siblingCopy.end(), item->id));
//        for(int i=0;i <parentItem->parents.size();i++){
//   //         if(item->parents[i] !=  callingId){
//           removeRows1( position,0,parentItem->id,child);

//        }

//    }


//   for(int i = 0; i < parentItem->siblingItems().size();i++){

//   auto sibling =  parentItem->siblingItems()[i];
//   if(sibling->acceptsCopies||sibling ==parentItem){
//   auto check = sibling->id.toString();
//   auto siblingIndex = match(index( 0, 0 ),Qt::UserRole +2,sibling->id.toString(),1,Qt::MatchRecursive);
//   auto res = sibling->id.toString();
//   if(siblingIndex.isEmpty()){
//       beginRemoveRows(QModelIndex(), position, position + rows - 1);

////         sibling->copyChildren.erase(std::find( sibling->copyChildren.begin(),  sibling->copyChildren.end(),  sibling->children()[position]->id));
//       const bool success = sibling->removeChildren(position, rows);

//        endRemoveRows();
//   }
//   else{
//   beginRemoveRows(siblingIndex[0], position, position + rows - 1);
//   auto siblingIndex = match(index( 0, 0 ),Qt::UserRole +2,sibling->children()[position]->parents[0].toString(),1,Qt::MatchRecursive);
//  auto parentId = getItem(siblingIndex[0]);
//   parentId->copyChildren.erase(std::find( parentId->copyChildren.begin(),  parentId->copyChildren.end(),  sibling->children()[position]->id));
//   for(int i = 0; i < sibling->children()[position]->copyChildren.size();i++ ){


//        auto siblingIndex = match(index( 0, 0 ),Qt::UserRole +2,sibling->children()[position]->copyChildren[i].toString(),1,Qt::MatchRecursive);
//        auto childItem = getItem(siblingIndex[0]);
//        childItem->parents.erase(std::find( childItem->parents.begin(),  childItem->parents.end(),  sibling->children()[position]->id));
//         childItem->parents.append(sibling->parents[0]);
//         parentId->copyChildren.append(childItem->id);

//}


//   const bool success = sibling->removeChildren(position, rows);

//    endRemoveRows();
//   }
//             //  parentItem->position.append((*parentItem->parents.get())[i]->childItems->indexOf(&(*(*(*(*parentItem->parents.get())[i]).childItems.get())[j])));


//}

//           }




updateProxyFilter();
    return true;
}
