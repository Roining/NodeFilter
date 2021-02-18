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

    SplitView.preferredHeight: 100
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
TreeView {
    id:waaa
    Shortcut {
    sequence: "Ctrl+K"
     context: Qt.ApplicationShortcut
    onActivated: {



         waaa.resizeColumnsToContents();
    }
    }

    Shortcut {
    sequence: "Ctrl+"
     context: Qt.ApplicationShortcut
    onActivated: {




    }
    }



    width:parent.width
    height:parent.height


//    width:100
    styleHints.overlay: "green"
    styleHints.indent: 25
    styleHints.columnPadding: 30



    property var parentIndex: waaa.model.parent(waaa.currentModelIndex)
    Keys.onPressed: {
     if((event.key == Qt.Key_P)&&(event.modifiers &Qt.ControlModifier)&&(event.modifiers &Qt.ShiftModifier)){ //acceptsCopies true Ctrl Shift P
        waaa.model.acceptsCopies(waaa.currentModelIndex,true)
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
      else if((event.key == Qt.Key_A)&&(event.modifiers &Qt.ControlModifier)){ //copy a copied node Ctrl A

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


    Keys.onDigit4Pressed: {

        event.accepted = true
        var test = waaa.currentModelIndex.parent
        console.log(test)
      waaa.model.copyRows(waaa.currentModelIndex.row,1,test,myClass.getLastIndex())//TODO
}
    Keys.onDigit5Pressed: {

//                                                event.accepted = true
       var test = waaa.currentModelIndex
        console.log(test)
      waaa.model.insertRows(0,1,test)//TODO

//        waaa.expand(waaa.currentModelIndex.row);
}
    Keys.onDigit9Pressed: {

        event.accepted = true
        var test = waaa.currentModelIndex
        console.log(test)
      waaa.model.copyRows(0,1,test,myClass.getLastIndex())//TODO
}
    Keys.onDigit6Pressed: {
    search.focus = true
    }
    Keys.onDigit7Pressed: {
     waaa.model.log()
    }

    Keys.onDigit1Pressed: {

        tee.destroy();
}
    Keys.onDigit3Pressed: {

        var test = waaa.model.parent(waaa.currentModelIndex)
        console.log("joo" + waaa.currentModelIndex)
     waaa.model.removeRows(waaa.currentModelIndex.row,1,test)//TODO
}
    Keys.onDigit2Pressed: {

        event.accepted = true
        var test = waaa.currentModelIndex.parent
        console.log(test)
      waaa.model.insertRows(waaa.currentModelIndex.row,1,test)//TODO
}
    Keys.onDigit8Pressed: {

        event.accepted = true
        var test = waaa.currentModelIndex
        console.log(test)
      waaa.model.saveIndex(test)//TODO
}

//    model: tee.test

    onCurrentIndexChanged: console.log("current index: " + currentIndex
                                           + " current row: " + currentIndex.row)


    delegate:


Component{
        id:ey

                                    Rectangle {

clip:true
//height:content.height




//                                        Shortcut {
//                                        sequence: "Ctrl+D"
//                                        onActivated:  {
//                                            var component = Qt.createQmlObject("import TreeModel.com 1.0; Filtering { id: car_1; }",
//                                                                                   you);
//                                    //        var source1 = source.createObject(you)

//                                            var   sprite = trie.createObject(tes,{model:component})


//                                        }
//                                        }
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
                                            Keys.onDigit0Pressed: {


                                                waaa.model.getIdToClipboard(waaa.currentModelIndex)

                                        }

                                            wrapMode:TextEdit.WordWrap
                                            textFormat: TextEdit.MarkdownText
                                            clip:true
                                            font.pointSize: 18
                                            x: indicator1.x + Math.max(waaa.styleHints.indent, indicator1.width * 1.5)
                                           text: edit
                                            onTextChanged:  {edit = text;
//waaa.resizeContent();
                                            }




                                        }
                               }
}



}

}
}
                }




