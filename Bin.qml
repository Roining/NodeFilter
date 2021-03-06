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
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.12
import QtQuick.TreeView 2.15
//import TreeModel.com 1.0
//import TreeModel.com1 1.0
import Qt.labs.platform 1.0
import QtQuick.Dialogs 1.1
import QtQuick.Layouts 1.11
import Qt.labs.qmlmodels 1.0

Component{
    Item{

        id:tee

         objectName: Math.random().toString(36).substr(2, 5)


        property alias test:waaa.model
        SplitView.minimumHeight: 200
        SplitView.preferredHeight:  you.height
        SplitView.minimumWidth:  100
        SplitView.preferredWidth: you.width/4
        SplitView.maximumWidth:   1920





Column{
    id: layout
width:parent.width
height:parent.height
    anchors.fill:parent
    spacing:0
    TextArea{
        wrapMode: "WrapAnywhere"
        selectByMouse:true
        selectionColor :"#3399FF"
selectedTextColor:"white"
width:tee.width
clip:true

    id:search
    signal info(string msg)
    objectName: "search"
Keys.onEscapePressed: {
waaa.forceActiveFocus()}

    placeholderText: "Search here"
    onInfo: {
    search.insert(search.length, ">:" + msg)
    }

    onTextChanged: {

        waaa.model.setBool(true)
        waaa.model.setQuery(text)



    }

    }

TreeView {


    contentHeight: 3000
    contentWidth:2000
    clip:true


    id:waaa
    property var rowHeight:40
    property var indexNow:waaa.currentModelIndex.row
reuseItems:true
rowHeightProvider: function(row){



   var array = [];
    for(var child in waaa.contentItem.children) {


if(waaa.contentItem.children[i].conHeight){
           array.push(waaa.contentItem.children[child].conHeight)}
    }


console.log("index.row after " + array);






        console.log("array " + array[row]);
        return waaa.contentItem.children[row].conHeight
    }

    width:tee.width
     height:tee.height

    styleHints.overlay: "green"
    styleHints.indent: 25
    styleHints.columnPadding: 30

property var parentIndex: waaa.model.parent(waaa.currentModelIndex)
        Keys.onDigit2Pressed: {

            console.log("contentHeight : " + waaa.height + " height: " + waaa.contentHeight)

    }
        MessageDialog {
            id: deleteDialog
            title: "Warning"
            text: "Are you sure you want to delete the selected node? Children nodes will also be deleted"
            onAccepted: {

                var test5 = waaa.model.parent(waaa.currentModelIndex)
                        console.log("joo" + waaa.currentModelIndex)
                     waaa.model.removeRows(waaa.currentModelIndex.row,1,test5)//TODO
                console.log("Selected node was deleted")
            }

        }

    Keys.onPressed: {
        if((event.key === Qt.Key_P)&&(event.modifiers &Qt.ControlModifier)&&(event.modifiers &Qt.ShiftModifier)){ //acceptsCopies true Ctrl Shift P
           waaa.model.acceptsCopies(waaa.currentModelIndex,true)
            return;
        }
     else if((event.key === Qt.Key_G)&&(event.modifiers &Qt.ControlModifier)&&(event.modifiers &Qt.ShiftModifier)){ //acceptsCopies true Ctrl Shift P
        allIndeces(waaa.currentModelIndex);

         return;
     }
     else if((event.key === Qt.Key_L)&&(event.modifiers &Qt.ControlModifier) &&(event.modifiers &Qt.ShiftModifier)){ //insert new node without transclusion

       waaa.model.insertRows(0,1,waaa.currentModelIndex,false)//TODO
        return;
    }

      else if((event.key === Qt.Key_N)&&(event.modifiers &Qt.ControlModifier) &&(event.modifiers &Qt.ShiftModifier)){ //insert new node as a child Ctrl Shift N
         var test4 = waaa.currentModelIndex
          console.log(test4)
        waaa.model.insertRows(0,1,test4)//TODO
            waaa.expandModelIndex(waaa.currentModelIndex)

         return;
     }
     else  if((event.key === Qt.Key_M)&&(event.modifiers &Qt.ControlModifier)&&(event.modifiers &Qt.ShiftModifier)){ //copy node as child Ctrl Shift M
         event.accepted = true
             var test2 = waaa.currentModelIndex
             console.log(test2)
           waaa.model.copyRows(0,1,test2,myClass.getLastIndex())//TODO
             waaa.expandModelIndex(waaa.currentModelIndex)
         return;
     }
     else if((event.key === Qt.Key_P)&&(event.modifiers &Qt.ControlModifier)){//acceptsCopies false Ctrl P
           waaa.model.acceptsCopies(waaa.currentModelIndex,false)
         return;
     }
      else if((event.key === Qt.Key_S)&&(event.modifiers &Qt.ControlModifier)){ //serialize/save Ctrl S
         waaa.model.log()
         return;
     }
        else if((event.key === Qt.Key_L)&&(event.modifiers &Qt.ControlModifier)){ //serialize/save Ctrl S
           var widtnewWidth = tee.width/2
            console.log("ttttttt " +widtnewWidth)
            tee.width = widtnewWidth
            var Randomnumber = Math.random().toString(36).substr(2, 5);
                  console.log(Randomnumber)
                  var component1 = Qt.createQmlObject("import TreeModel.com 1.0; Filtering { id: car_" +  Randomnumber + "; }",
                                                         you);
                  var Randomnumber1 = Math.random().toString(36).substr(2, 5);
                  var delegateInstance = Qt.createQmlObject("import QtQuick 2.15;Delegate { id: car_" +  Randomnumber1 + ";}",
                                                         you);
                  var   sprite = delegateInstance.createObject(tes,{test:component1,width:widtnewWidth})
           return;
       }
      else if((event.key === Qt.Key_D)&&(event.modifiers &Qt.ControlModifier)){ //remove node Ctrl D

            deleteDialog.open()
         return;
         }
     else if((event.key === Qt.Key_U)&&(event.modifiers &Qt.ControlModifier)){ //remove node Ctrl D

             content.focus = true
        return;
        }
        else if((event.key === Qt.Key_O)&&(event.modifiers &Qt.ControlModifier)){ //remove node Ctrl D

            search.forceActiveFocus()
            search.clear()
            search.append(">:"+waaa.model.getId(waaa.currentModelIndex))
           return;
           }
      else if((event.key === Qt.Key_Q)&&(event.modifiers &Qt.ControlModifier)){ //copy a copied node Ctrl A

         var test3 = waaa.currentModelIndex
                 console.log(test3)
               waaa.model.saveIndex(test3)//TODO
         return;
     }
      else if((event.key === Qt.Key_E)&&(event.modifiers &Qt.ControlModifier)){ //copy Id to clipboard Ctrl E
        waaa.model.getIdToClipboard(waaa.currentModelIndex)
         return;
     }

      else if((event.key === Qt.Key_F)&&(event.modifiers &Qt.ControlModifier)){//Ctrl F
         search.focus = true
         return;
     }
      else if((event.key === Qt.Key_W)&&(event.modifiers &Qt.ControlModifier)){ // Delete view Alt D
     tee.destroy();
         return;
     }

      else if((event.key === Qt.Key_N)&&(event.modifiers &Qt.ControlModifier)){ //Ctrl N insert node
         var test1 = waaa.currentModelIndex.parent
         console.log(test1)
       waaa.model.insertRows(waaa.currentModelIndex.row+1,1,test1)//TODO
         return;
     }
     else if((event.key === Qt.Key_M)&&(event.modifiers &Qt.ControlModifier)){ //Ctrl M copy node
         event.accepted = true
                 var test6 = waaa.currentModelIndex.parent
                 console.log(test6)
               waaa.model.copyRows(waaa.currentModelIndex.row,1,test6,myClass.getLastIndex())//TODO
    }
     else if((event.key === Qt.Key_G)&&(event.modifiers &Qt.ControlModifier)){ //Ctrl M copy node
         waaa.toggleModelIndexExpanded(waaa.currentModelIndex)

    }

     }

onCurrentIndexChanged: {
itemAtIndex(waaa.currentIndex).forceActiveFocus()}
function allIndeces(ind) {

waaa.expandModelIndex(ind)
    for(var i=0; i < waaa.model.rowCount(ind); i++) {
       waaa.expandModelIndex(ind)
        var index = waaa.model.index(i,0,ind)
        console.log("current index: ")
         waaa.expandModelIndex(index)
        if (waaa.model.rowCount(index)!==0){
            console.log(waaa.model.rowCount(index))
            allIndeces(index)
        }




   }

return;}
delegate:
Component{
        id:ey
                                    Rectangle {

clip:true

                                 id:newId

                                 onActiveFocusChanged:  {
                                    if(activeFocus){
                                         var posInTreeView = mapToItem (tee,0, 0)
                                         var row = waaa.rowAtY(posInTreeView.y, true)
                                         waaa.currentIndex = waaa.viewIndex(0, row);
content.forceActiveFocus()
                                         console.log("ttttt "+posInTreeView)
}



                                 }

                                        visible:true
                                        property var conHeight: content.height
                                        implicitHeight: conHeight
                                        implicitWidth: (tee.width ? tee.width:1920)
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

                                                TapHandler {
                                                    id:dotTapHandler
                                                    onTapped: {
                                                        var posInTreeView = waaa.mapFromItem(parent, point.position)
                                                        var row = waaa.rowAtY(posInTreeView.y, true)
                                                        waaa.currentIndex = waaa.viewIndex(0, row);
                                                        console.log("function row  "+row + "  index row  " + waaa.currentIndex.row )

                                                        if (tapCount == 1)

                                                                                                                    search.forceActiveFocus()
                                                                                                                    search.clear()
                                                                                                                    search.append(">:"+waaa.model.getId(waaa.currentModelIndex))

                                                    }
                                                }
                                        }

                                        TextArea {
                                            width:newId.width
                                            id:content
//                                            TextArea.flickable:
//                                            Timer {
//                                                   interval: 50; running: true; repeat: true
//                                                   onTriggered: waaa.forceLayout()

//                                               }
//
                                            focus:true
                                            onActiveFocusChanged: {
                                                if (activeFocus) {
                                                    var posInTreeView = content.mapToItem (waaa,0, 0)
                                                    var row = waaa.rowAtY(posInTreeView.y, true)
                                                    waaa.currentIndex = waaa.viewIndex(0, row);

                                                    console.log("olllllllllllll")


                                                        }
                                                else{
                                                    editingFinished()
                                                    console.log("iiiiiiiiiii")

                                                }
                                            }
                                            selectByMouse:true
                                            selectionColor :"#3399FF"
                                    selectedTextColor:"white"
                                            objectName: "text"
                                               wrapMode: "WrapAnywhere"
                                            textFormat: TextEdit.MarkdownText
                                            clip:true

                                            property var hght:content.height
                                            font.pointSize: 18

//                                            property var terk:function(edit){
//                                            return content.edit}

//onHeightChanged: waaa.forceLayout()
//Keys.onEnabledChanged: waaa.forceLayout()
//                                            onContentHeightChanged:

//                                            onContentHeightChanged:{
//                                                waaa.forceLayout();
//                                            }
                                            x: indicator1.x + Math.max(waaa.styleHints.indent, indicator1.width * 1.5)
//onLineCountChanged:  waaa.forceLayout()
                                            text:edit
onEditingFinished: {

//waaa.forceLayout()
}
                                            onTextChanged:          {

                                               if(waaa.activeFocus){
                                                   edit = text;
//                                                   edit = text;
//                                           waaa.forceLayout();
                                               }
//                                                parent.parent.parent.forceLayout()

//                                                waaa.rowHeight = content.height;
//                                                    waaa.forceLayout();
//                                                    console.log("rowHeightProvider " + waaa.rowHeightProvider )
//                                                    console.log("content.height " + content.height )


                                            }




                                        }

                               }
}

//    MouseArea {
//                            anchors.fill: parent
//                            onWheel: {
//                                if (wheel.angleDelta.y > 0) vbar.increase()
//                                else vbar.decrease()
//                            }
//                        }
    ScrollBar.horizontal: ScrollBar { id: hbar;height:20;
        policy: ScrollBar.AlwaysOn;active: true;}
                ScrollBar.vertical: ScrollBar { id: vbar;width:15; policy: ScrollBar.AlwaysOn;active: true;}
}



}
}






}
