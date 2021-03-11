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
  property alias tree:waaa
         objectName: Math.random().toString(36).substr(2, 5)


        property alias test:waaa.model
        SplitView.minimumHeight: 200
        SplitView.preferredHeight:  you1.height/2
        SplitView.minimumWidth:  100
        SplitView.preferredWidth: you1.width/4
        SplitView.maximumWidth:   1920





Column{
    id: layout
width:parent.width
height:parent.height
anchors.fill:parent
spacing:0
     TextArea{
        width:tee.width
//        background: "yellow"
//        topInset: 10
        wrapMode: "WrapAnywhere"
        selectByMouse:true
        selectionColor :"#3399FF"
selectedTextColor:"white"

clip:true

    id:search
    signal info(string msg)
    objectName: "search"
Keys.onEscapePressed: {


    var posInTreeView = mapToItem (waaa,0, 0)
                                                    console.log("ttttt "+waaa.currentModelIndex)
                                                   var row = waaa.rowAtY(posInTreeView, true)
                                                   waaa.currentModelIndex = waaa.viewIndex(0, row);
   //        waaa.forceActiveFocus()
   waaa.itemAtModelIndex(waaa.currentModelIndex).item.forceActiveFocus()
//itemAtModelIndex(waaa.currentModelIndex).item.forceActiveFocus()//focus =false
//waaa.forceActiveFocus()
}

    placeholderText: "Search here"
    onInfo: {
    search.insert(search.length, ">:" + msg)
    }

    onTextChanged: {

        waaa.model.setQuery(text)
    }
    }

TreeView {


    contentHeight: 3000
    contentWidth:2000
    clip:true

    Component.onCompleted: {
        var posInTreeView = mapToItem (waaa,0, 0)
                                                        console.log("ttttt "+waaa.currentModelIndex)
                                                       var row = waaa.rowAtY(posInTreeView, true)
                                                       waaa.currentModelIndex = waaa.viewIndex(0, 0);
       //        waaa.forceActiveFocus()
       waaa.itemAtModelIndex(waaa.currentModelIndex).forceActiveFocus()
    }


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
     height:tee.height - search.height

    styleHints.overlay: "green"
    styleHints.indent: 25
    styleHints.columnPadding: 30

property var parentIndex: waaa.model.parent(waaa.currentModelIndex)
        Keys.onDigit2Pressed: {

            for(var i =0;i< you1.viewArray.length;i++){
            if(you1.viewArray[i].objectName.toString() ===tee.objectName.toString()){
                console.log("contentHeight : " +   you1.viewArray +  " tee.objectName " +you1.viewArray[i] + "  objectName " + you1.viewArray[i+1])
                if((i+1)<you1.viewArray.length){
                you1.viewArray[i+1].tree.itemAtModelIndex( you1.viewArray[i+1].tree.currentModelIndex).item.forceActiveFocus()
                }
                break;
            }
            }




    }
        MessageDialog {
            id: deleteDialog
            title: "Warning"
            text: "Are you sure you want to delete the selected node? Children nodes will also be deleted"
            onAccepted: {

                     myClass.removeRows(waaa.currentModelIndex.row,1,waaa.model.mapToSourceProxy(waaa.currentModelIndex).parent)//TODO
                console.log("Selected node was deleted")
            }

        }

    Keys.onPressed: {
        if((event.key === Qt.Key_P)&&(event.modifiers &Qt.ControlModifier)&&(event.modifiers &Qt.ShiftModifier)){ //acceptsCopies true Ctrl Shift P
           myClass.acceptsCopies(waaa.model.mapToSourceProxy(waaa.currentModelIndex),true)
            return;
        }
     else if((event.key === Qt.Key_G)&&(event.modifiers &Qt.ControlModifier)&&(event.modifiers &Qt.ShiftModifier)){ //acceptsCopies true Ctrl Shift P
        allIndeces(waaa.currentModelIndex);

         return;
     }
        else if((event.key === Qt.Key_I)&&(event.modifiers &Qt.ControlModifier) ){ //acceptsCopies true Ctrl Shift P
            for(var i =0;i< you1.viewArray.length;i++){
                console.log("contentHeight : " + you1.viewArray +  " tee.objectName " +you1.viewArray[i] + "  objectName " + you1.viewArray[i-1])

                   if(you1.viewArray[i].objectName.toString() ==tee.objectName.toString()){
                       console.log("contentHeight : " + you1.viewArray +  " tee.objectName " +you1.viewArray[i] + "  objectName " + you1.viewArray[i-1])
                       if((i-1)> -1){
                       you1.viewArray[i-1].tree.itemAtModelIndex( you1.viewArray[i-1].tree.currentModelIndex).item.forceActiveFocus()
                       }
                       break;
                   }
                   }
                return;
            }
        else if((event.key === Qt.Key_Tab)&&(event.modifiers &Qt.ControlModifier)){ //acceptsCopies true Ctrl Shift P
            for(var i =0;i< you1.viewArray.length;i++){
                   if(you1.viewArray[i].objectName.toString() ===tee.objectName.toString()){
                       console.log("contentHeight : " + you1.viewArray +  " tee.objectName " +you1.viewArray[i] + "  objectName " + you1.viewArray[i+1])
                       if((i+1)<you1.viewArray.length){
                       you1.viewArray[i+1].tree.itemAtModelIndex( you1.viewArray[i+1].tree.currentModelIndex).item.forceActiveFocus()
                       }
                       break;
                   }
                   }
            return;
        }
//     else if((event.key === Qt.Key_L)&&(event.modifiers &Qt.ControlModifier) &&(event.modifiers &Qt.ShiftModifier)){ //insert new node without transclusion

//      myClass.insertRows(0,1,waaa.mo,false)//TODO
//        return;
//    }

      else if((event.key === Qt.Key_N)&&(event.modifiers &Qt.ControlModifier) &&(event.modifiers &Qt.ShiftModifier)){ //insert new node as a child Ctrl Shift N

      myClass.insertRows(0,1,waaa.model.mapToSourceProxy(waaa.currentModelIndex))//TODO
            waaa.expandModelIndex(waaa.currentModelIndex)

         return;
     }
     else  if((event.key === Qt.Key_M)&&(event.modifiers &Qt.ControlModifier)&&(event.modifiers &Qt.ShiftModifier)){ //copy node as child Ctrl Shift M
         event.accepted = true


          myClass.copyRows(0,1,waaa.model.mapToSourceProxy(waaa.currentModelIndex),myClass.getLastIndex())//TODO
             waaa.expandModelIndex(waaa.currentModelIndex)
         return;
     }
     else if((event.key === Qt.Key_P)&&(event.modifiers &Qt.ControlModifier)){//acceptsCopies false Ctrl P
          myClass.acceptsCopies(waaa.model.mapToSourceProxy(waaa.currentModelIndex),false)
         return;
     }
        else if((event.key === Qt.Key_R)&&(event.modifiers &Qt.ControlModifier)){//acceptsCopies false Ctrl P
            var arrayIndex = you1.viewArray.indexOf(tee.objectName)
            you1.viewArray[arrayIndex+1]

            return;
        }
//        else if((event.key === Qt.MiddleButton)&&(event.modifiers &Qt.ControlModifier)){ //Ctrl M copy node
//            if()

//       }
      else if((event.key === Qt.Key_S)&&(event.modifiers &Qt.ControlModifier)){ //serialize/save Ctrl S
        myClass.log()
         return;
     }
        else if((event.key === Qt.Key_H)&&(event.modifiers &Qt.ControlModifier)){ //serialize/save Ctrl S
            var Randomnumber = Math.random().toString(36).substr(2, 5);
            console.log(Randomnumber)
            var component = Qt.createQmlObject("import TreeModel.com 1.0; Filtering { id: car_" +  Randomnumber + "; }",
                                                   you1);
            var Randomnumber1 = Math.random().toString(36).substr(2, 5);
            var delegateInstance = Qt.createQmlObject("Delegate { id: car_" +  Randomnumber1 + "; }",
                                                   you);
            var   sprite = delegateInstance.createObject(split,{test:component})
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
//     else if((event.key === Qt.Key_U)&&(event.modifiers &Qt.ControlModifier)){ //remove node Ctrl D

//             content.focus = true
//        return;
//        }

        else if((event.key === Qt.Key_U)&&(event.modifiers &Qt.ControlModifier)){ //remove node Ctrl D

                hbar.decrease()
           return;
           }
        else if((event.key === Qt.Key_O)&&(event.modifiers &Qt.ControlModifier)){ //remove node Ctrl D

            search.forceActiveFocus()
            search.clear()
            search.append(">:"+myClass.getId(waaa.model.mapToSourceProxy(waaa.currentModelIndex)))
           return;
           }
      else if((event.key === Qt.Key_Q)&&(event.modifiers &Qt.ControlModifier)){ //copy a copied node Ctrl A

               myClass.saveIndex(waaa.model.mapToSourceProxy(waaa.currentModelIndex))//TODO
         return;
     }
      else if((event.key === Qt.Key_E)&&(event.modifiers &Qt.ControlModifier)){ //copy Id to clipboard Ctrl E
       myClass.getIdToClipboard(waaa.model.mapToSourceProxy(waaa.currentModelIndex))
         return;
     }

      else if((event.key === Qt.Key_F)&&(event.modifiers &Qt.ControlModifier)){//Ctrl F
         search.forceActiveFocus()
            search.selectAll();
         return;
     }
      else if((event.key === Qt.Key_W)&&(event.modifiers &Qt.ControlModifier)){ // Delete view Alt D
     tee.destroy();
         return;
     }

      else if((event.key === Qt.Key_N)&&(event.modifiers &Qt.ControlModifier)){ //Ctrl N insert node
      myClass.insertRows(waaa.currentModelIndex.row+1,1,waaa.model.mapToSourceProxy(waaa.currentModelIndex).parent)//TODO

         return;
     }
        else if((event.key === Qt.Key_J)&&(event.modifiers &Qt.ControlModifier)){ //Ctrl N insert node
           var test1 = waaa.currentModelIndex.parent
           console.log(test1)

        waaa.currentModelIndex

           return;
       }
     else if((event.key === Qt.Key_M)&&(event.modifiers &Qt.ControlModifier)){ //Ctrl M copy node
         event.accepted = true

               myClass.copyRows(waaa.currentModelIndex.row +1,1,waaa.model.mapToSourceProxy(waaa.currentModelIndex).parent,myClass.getLastIndex())//TODO
    }
     else if((event.key === Qt.Key_G)&&(event.modifiers &Qt.ControlModifier)){ //Ctrl M copy node
         waaa.toggleModelIndexExpanded(waaa.currentModelIndex)
            console.log("hhhh " + waaa.currentIndex)
            console.log("hhhhmodel " + waaa.currentModelIndex)

    }


     }
    MouseArea {
        anchors.fill:parent
        onWheel: {

            if (wheel.modifiers & Qt.ShiftModifier) {
                if(wheel.angleDelta.y >0 ){
                hbar.increase()}
                else if(wheel.angleDelta.y <0) {
                    hbar.decrease()
                }

            }
            else if(wheel.angleDelta.y <0){

                vbar.increase()
            }
                else if(wheel.angleDelta.y >0){
                vbar.decrease()}
        }
    }
onCurrentIndexChanged: {
    if(myClass.hasMultipleSiblings(waaa.model.mapToSourceProxy(waaa.currentModelIndex))){
     itemAtModelIndex(waaa.currentModelIndex).dot.color = "blue"

    }
    console.log("hhhh " + waaa.currentIndex)
    console.log("hhhhmodel " + waaa.currentModelIndex.row)


    if((waaa.currentModelIndex.row !== -1)&&(!search.focus) ){
if(waaa.activeFocus){
    itemAtModelIndex(waaa.currentModelIndex).item.forceActiveFocus()
    console.log("77777777777 " + waaa.currentModelIndex.row)

        }
    }
//    else{
////        var posInTreeView = mapToItem (waaa,0, 0)
////                                                 console.log("ttttt "+waaa.currentModelIndex)
////                                                var row = waaa.rowAtY(0, true)
////                                                waaa.currentModelIndex = waaa.viewIndex(0, row);
//////        waaa.forceActiveFocus()
////itemAtModelIndex(waaa.currentModelIndex).item.forceActiveFocus()
////        itemAtIndex(waaa.currentIndex).item.forceActiveFocus()
////        console.log("yyyy " +waaa.currentIndex)

//    }
}
function allIndeces(ind) {

waaa.expandModelIndex(ind)
    for(var i=0; i < waaa.model.rowCount(ind); i++) {
       waaa.expandModelIndex(ind)
        var index = waaa.model.index(i,0,ind)

         waaa.expandModelIndex(index)
        if (waaa.model.rowCount(index)!==0){

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
//onActiveFocusChanged: {
//if(activeFocus){
//            if((waaa.currentModelIndex.row !== -1)&&(!search.focus) ){
//        if(itemAtModelIndex(waaa.currentModelIndex).focus){
//            itemAtModelIndex(waaa.currentModelIndex).item.forceActiveFocus()
//            console.log("77777777777 " + waaa.currentModelIndex.row)

//                }
//            }
//        }
//}
//                                 onActiveFocusChanged:  {
//                                    if(activeFocus&&content.focus == false){
//                                         var posInTreeView = mapToItem (waaa,0, 0)
//                                          console.log("ttttt "+waaa.currentModelIndex)
//                                         var row = waaa.rowAtY(posInTreeView.y, true)
//                                         waaa.currentIndex = waaa.viewIndex(0, row);
////content.forceActiveFocus()
//                                         console.log("ttttt after "+waaa.currentModelIndex)
//}



//                                 }
                                property alias item:content
                                 property alias dot:ball1

                                        visible:true
                                        property var conHeight: content.height
                                        implicitHeight: conHeight
//                                        implicitWidth: (tee.width ? tee.width:1920)
                                        implicitWidth: you1.width
                                            focus:true
                                            property bool hasFocus
                                        property bool hasChildren: TreeView.hasChildren
                                        property bool isExpanded: TreeView.isExpanded
                                        property int depth: TreeView.depth


                                        Text {
                                            id: indicator1
                                            x: depth * waaa.styleHints.indent +5

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
//                                                property alias currentView
//                                               Component.onCompleted:  {


//                                                   }}
                                                x: depth * waaa.styleHints.indent +15
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
                                                                                                                    search.selectAll()
                                                                                                                    search.append(">:"+myClass.getId(waaa.model.mapToSourceProxy(waaa.currentModelIndex)))

                                                    }
                                                }
                                        }

                                        TextArea {
                                            width:newId.width
                                            id:content


//                                            focus:true
//                                            onActiveFocusChanged: {
//                                            if(activeFocus&&focusReason === Qt.MouseFocusReason){
//                                            newId.focus = true}}
                                            onActiveFocusChanged: {
                                                if (activeFocus) {
//                                                    content.textFormat = TextEdit.PlainText
                                                    var posInTreeView = content.mapToItem (waaa,0, 0)
                                                    var row = waaa.rowAtY(posInTreeView.y, true)
                                                    waaa.currentIndex = waaa.viewIndex(0, row);
                                                        }
                                                else{
                                                    editingFinished()

                                                    console.log("iiiiiiiiiii")

                                                }
                                            }
                                            Component.onCompleted: {
                                            content.isCompleted = 0;
                                            console.log(content.isCompleted)}
                                            selectByMouse:true
                                            selectionColor :"#3399FF"
                                    selectedTextColor:"white"
                                            objectName: "text"
                                            wrapMode: "WrapAnywhere"
                                            textFormat: TextEdit.MarkdownText

                                            clip:true
                                            property var isCompleted:1

                                            property var hght:content.height
                                            font.pointSize: 18

anchors.left: ball1.right
anchors.leftMargin: 5
//                                            x: indicator1.x + Math.max(waaa.styleHints.indent, indicator1.width * 1.5)
onHeightChanged: {
//if(content.activeFocus){
//    console.log("height  "+content.height)
//    waaa.forceLayout()

//}
}
                                            text:edit

                                            onTextChanged:          {

                                                if(waaa.activeFocus){
                                                    edit = text;

                                                }
                                               if(content.activeFocus){
                                                   console.log("height  "+content.height)
                                                   waaa.forceLayout()

                                               }



                                              }




                                        }

                               }

}


    ScrollBar.horizontal: ScrollBar { id: hbar;height:12;
        policy: ScrollBar.AlwaysOn;active: true;}
                ScrollBar.vertical: ScrollBar { id: vbar;width:12; policy: ScrollBar.AlwaysOn;active: true;}
}



}
}






}
