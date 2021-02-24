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
         objectName: Math.random().toString(36).substr(2, 5)
          opacity: 1.0
//z:1000
        property alias test:waaa.model
        SplitView.minimumHeight: 200
        SplitView.preferredHeight:  300
        SplitView.minimumWidth:  100
        SplitView.preferredWidth:  500
        SplitView.maximumWidth:   1920




//    Item{
//        SplitView.preferredHeight:  300
Column{
    id: layout

    anchors.fill:parent
    spacing:0
    TextArea{
    //    anchors.top:waaa.bottom
    id:search
    signal info(string msg)
    objectName: "search"

//    SplitView.preferredHeight: 100
    placeholderText: "Search here"
    onInfo: {
    search.insert(search.length, ">:" + msg)
    }
    //focus:true
    onTextChanged: {

        waaa.model.setBool(true)
        waaa.model.setQuery(text)



    }

    }
//ScrollView{
//clip:true

//contentWidth:waaa.width
//contentHeight:waaa.height
//            ScrollBar.vertical.policy: ScrollBar.AlwaysOn
//             ScrollBar.horizontal.policy: ScrollBar.AlwaysOn
TreeView {
//    ScrollBar.horizontal:   ScrollBar {
//        active: ScrollBar.AlwaysOn
//        policy: ScrollBar.AlwaysOn}
    clip:true
//    verticalOvershoot :0
//   boundsBehavior : Flickable.StopAtBounds
//    boundsMovement: Flickable.StopAtBounds
//boundsBehavior:Flickable.StopAtBounds
    id:waaa
    property var rowHeight:40
    property var indexNow:waaa.currentModelIndex.row
reuseItems:true
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

    width:layout.width
     height:layout.height
//    width:100f
    styleHints.overlay: "green"
    styleHints.indent: 25
    styleHints.columnPadding: 30
    property var parentIndex: waaa.model.parent(waaa.currentModelIndex)
        Keys.onDigit2Pressed: {

            console.log(waaa.height)

    }
    Keys.onPressed: {
     if((event.key == Qt.Key_P)&&(event.modifiers &Qt.ControlModifier)&&(event.modifiers &Qt.ShiftModifier)){ //acceptsCopies true Ctrl Shift P
        waaa.model.acceptsCopies(waaa.currentModelIndex,true)
         return;
     }
     else if((event.key == Qt.Key_L)&&(event.modifiers &Qt.ControlModifier) &&(event.modifiers &Qt.ShiftModifier)){ //insert new node without transclusion

       waaa.model.insertRows(0,1,waaa.currentModelIndex,false)//TODO
//         waaa.expand(test.row);
        return;
    }

      else if((event.key == Qt.Key_N)&&(event.modifiers &Qt.ControlModifier) &&(event.modifiers &Qt.ShiftModifier)){ //insert new node as a child Ctrl Shift N
         var test4 = waaa.currentModelIndex
          console.log(test4)
        waaa.model.insertRows(0,1,test4)//TODO
 //         waaa.expand(test.row);
         return;
     }
     else  if((event.key == Qt.Key_M)&&(event.modifiers &Qt.ControlModifier)&&(event.modifiers &Qt.ShiftModifier)){ //copy node as child Ctrl Shift M
         event.accepted = true
             var test2 = waaa.currentModelIndex
             console.log(test2)
           waaa.model.copyRows(0,1,test2,myClass.getLastIndex())//TODO
         return;
     }
     else if((event.key == Qt.Key_P)&&(event.modifiers &Qt.ControlModifier)){//acceptsCopies false Ctrl P
           waaa.model.acceptsCopies(waaa.currentModelIndex,false)
         return;
     }
      else if((event.key == Qt.Key_S)&&(event.modifiers &Qt.ControlModifier)){ //serialize/save Ctrl S
         waaa.model.log()
         return;
     }
      else if((event.key == Qt.Key_D)&&(event.modifiers &Qt.ControlModifier)){ //remove node Ctrl D
         var test5 = waaa.model.parent(waaa.currentModelIndex)
                 console.log("joo" + waaa.currentModelIndex)
              waaa.model.removeRows(waaa.currentModelIndex.row,1,test5)//TODO
         return;
         }
     else if((event.key == Qt.Key_U)&&(event.modifiers &Qt.ControlModifier)){ //remove node Ctrl D

             content.focus = true
        return;
        }
      else if((event.key == Qt.Key_Q)&&(event.modifiers &Qt.ControlModifier)){ //copy a copied node Ctrl A

         var test3 = waaa.currentModelIndex
                 console.log(test3)
               waaa.model.saveIndex(test3)//TODO
         return;
     }
      else if((event.key == Qt.Key_E)&&(event.modifiers &Qt.ControlModifier)){ //copy Id to clipboard Ctrl E
        waaa.model.getIdToClipboard(waaa.currentModelIndex)
         return;
     }
      else if((event.key == Qt.Key_F)&&(event.modifiers &Qt.ControlModifier)){//Ctrl F
         search.focus = true
         return;
     }
      else if((event.key == Qt.Key_D)&&(event.modifiers &Qt.AltModifier)){ // Delete view Alt D
         console.log("vcvhgvhn")
        tee.destroy();
         return;
     }

      else if((event.key == Qt.Key_N)&&(event.modifiers &Qt.ControlModifier)){ //Ctrl N insert node
         var test1 = waaa.currentModelIndex.parent
         console.log(test1)
       waaa.model.insertRows(waaa.currentModelIndex.row,1,test1)//TODO
         return;
     }
     else if((event.key == Qt.Key_M)&&(event.modifiers &Qt.ControlModifier)){ //Ctrl M copy node
         event.accepted = true
                 var test6 = waaa.currentModelIndex.parent
                 console.log(test6)
               waaa.model.copyRows(waaa.currentModelIndex.row,1,test6,myClass.getLastIndex())//TODO
    }
     else if((event.key == Qt.Key_M)&&(event.modifiers &Qt.AltModifier)){ //Ctrl M copy node
         var Randomnumber = Math.random().toString(36).substr(2, 5);
         console.log(Randomnumber)
         var component = Qt.createQmlObject("import TreeModel.com 1.0; Filtering { id: car_" +  Randomnumber + "; }",
                                                you);
         var Randomnumber1 = Math.random().toString(36).substr(2, 5);
         var delegateInstance = Qt.createQmlObject("Delegate { id: car_" +  Randomnumber1 + "; }",
                                                you);
         var   sprite = delegateInstance.createObject(tes,{test:component})
    }
     }

onCurrentIndexChanged: console.log("current index: " + currentIndex
                                           + " current row: " + currentIndex.row)
    delegate:
Component{
        id:ey
                                    Rectangle {

clip:true
//onHeightChanged: waaa.forceLayout()
//height:content.height

                                        id:newId
                                        visible:true
                                        property var conHeight: content.height
                                        implicitHeight: conHeight
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
                                            objectName: "text"
                                            wrapMode:TextEdit.WordWrap
                                            textFormat: TextEdit.MarkdownText
                                            clip:true
                                            property var hght:content.height
                                            font.pointSize: 18
//onHeightChanged: waaa.forceLayout()
//                                            onContentHeightChanged:

//                                            onContentHeightChanged:{
//                                                waaa.forceLayout();
//                                            }
                                            x: indicator1.x + Math.max(waaa.styleHints.indent, indicator1.width * 1.5)
                                            text: edit
                                            onTextChanged:  {edit = text;
                                                waaa.forceLayout()

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
                ScrollBar.vertical: ScrollBar { id: vbar;width:15; policy: ScrollBar.AlwaysOn;active: hovered || pressed;}
}



}
}

                }




