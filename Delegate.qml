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


                                            x: indicator1.x + Math.max(waaa.styleHints.indent, indicator1.width * 1.5)

                                            text:edit
onEditingFinished: {


}
                                            onTextChanged:          {

                                               if(waaa.activeFocus){
                                                   edit = text;

                                               }



                                            }




                                        }

                               }
}


    ScrollBar.horizontal: ScrollBar { id: hbar;height:20;
        policy: ScrollBar.AlwaysOn;active: true;}
                ScrollBar.vertical: ScrollBar { id: vbar;width:15; policy: ScrollBar.AlwaysOn;active: true;}
}



}
}






}
