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

         function allIndeces(ind) {

waaa.expandModelIndex(ind)
             for(var i=0; i < waaa.model.rowCount(ind); i++) {
                waaa.expandModelIndex(ind)
                 var index = waaa.model.index(i,0,ind)
                 console.log("waaa.model.index(i,0,ind)) "+ waaa.model.index(i,0,ind))
                 console.log("waaa.model.rowCount(index)"+ waaa.model.rowCount(index))
                 console.log("data ind "+ waaa.model.data(ind ))
                console.log("data index "+ waaa.model.data(index ))
//                 console.log("valid ind "+ waaa.model.data(ind ).valid)


                  waaa.expandModelIndex(index)
                 if (waaa.model.rowCount(index)!==0){
                     console.log(waaa.model.rowCount(index))
                     allIndeces(index)
                 }




            }

return;}

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

property var rowHeight: 0


//    width:100
    styleHints.overlay: "green"
    styleHints.indent: 0
    styleHints.columnPadding: 30


    property var parentIndex: waaa.model.parent(waaa.currentModelIndex)
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
                                           + " current row: " + currentIndex.row+ " modelImdex: " + currentModelIndex)


    delegate:



DelegateChooser{
        id:delegateChooser
        role: "enabled"
        DelegateChoice{
            roleValue: "true"
            Rectangle {



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
                    x: waaa.styleHints.indent

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
                        x: indicator1.width*1.5
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
                    x: ball1.width * 1,5 +  indicator1.width * 1.5
                   text: edit
                    onTextChanged:  {edit = text

                    }



                }
       }
    }
        DelegateChoice{
        roleValue: "false"
//        Component.onCompleted:{ waaa.rowHeightProvider = 0
//        waaa.forceLayout();
//        }
        Rectangle {


                        id:newId2
                        visible:true
                        width:0
                        height:0
                        implicitHeight: 1
                        implicitWidth: 1


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
     allIndeces(waaa.model.index(0,0).parent)


}

}

}
                }





import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.12
import QtQuick.TreeView 2.15
import TreeModel.com 1.0
//import TreeModel.com1 1.0
import Qt.labs.platform 1.0
import QtQuick.Layouts 1.11
import Qt.labs.qmlmodels 1.0


ApplicationWindow {
    id:you
property var arrayOfViews
    MouseArea{
            id: ma
            anchors.fill: parent
            onClicked: {
               you.contentItem.childAt(mouseX, mouseY)
                console.log(you.contentItem.childAt(mouseX, mouseY))
            }
        }
property var viewArray: [];
    Component.onCompleted:{
            var Randomnumber = Math.random().toString(36).substr(2, 5);
            console.log(Randomnumber)
            var component = Qt.createQmlObject("import TreeModel.com 1.0; Filtering { id: car_" +  Randomnumber + "; }",
                                                   you);
            var Randomnumber1 = Math.random().toString(36).substr(2, 5);
            var delegateInstance = Qt.createQmlObject("Delegate { id: car_" +  Randomnumber1 + "; }",
                                                   you);
            var   sprite = delegateInstance.createObject(tes,{test:component})
        you.viewArray.push(sprite)


    }


    SearchProxy{
    id:find
    }
    Filtering{
    id:source
    }
    Delegate{
        id:trie

    }
    function getRandomArbitrary(min, max) {
        return Math.random() * (max - min) + min;
    }
    Shortcut {
    sequence: "Ctrl+Shift+F"
    onActivated:  {
//        var Randomnumber = Math.random().toString(36).substr(2, 5);
        var Randomnumber = Math.random().toString(36).substr(2, 5);

        console.log(Randomnumber)
        var component = Qt.createQmlObject("import TreeModel.com 1.0; Filtering { id: car_" +  Randomnumber + "; }",
                                               you);
        var Randomnumber1 = Math.random().toString(36).substr(2, 5);
        var delegateInstance = Qt.createQmlObject("SearchProxy { id: car_" +  Randomnumber1 + "; }",
                                               you);
        var   sprite = delegateInstance.createObject(tes,{test:component})


    }
    }

    Shortcut {
    sequence: "Ctrl+T"
    onActivated:  {
        var Randomnumber = Math.random().toString(36).substr(2, 5);
        console.log(Randomnumber)
        var component = Qt.createQmlObject("import TreeModel.com 1.0; Filtering { id: car_" +  Randomnumber + "; }",
                                               you);
        var Randomnumber1 = Math.random().toString(36).substr(2, 5);
        var delegateInstance = Qt.createQmlObject("Delegate { id: car_" +  Randomnumber1 + "; }",
                                               you);
        var   sprite = delegateInstance.createObject(tes,{test:component})
//        sprite.focus === true;
        you.viewArray.push(sprite)

    }
    }
    Shortcut {
    sequence: "Ctrl+K"
    onActivated:  {
        var component = Qt.createComponent("Window.qml")
                    var window    = component.createObject()
                    window.show()
//        var Randomnumber = Math.random().toString(36).substr(2, 5);
//        console.log(Randomnumber)
//        var component = Qt.createQmlObject("import TreeModel.com 1.0; Filtering { id: car_" +  Randomnumber + "; }",
//                                               you);
//        var Randomnumber1 = Math.random().toString(36).substr(2, 5);
//        var delegateInstance = Qt.createQmlObject("Window { id: car_" +  Randomnumber1 + "; }",
//                                               you);
//        var   sprite = delegateInstance.createObject(tes,{test:component})

    }
    }

//    Shortcut {
//    sequence: "Ctrl+"
//    onActivated:  {
//        var Randomnumber = Math.random().toString(36).substr(2, 5);
//        console.log(Randomnumber)
//        var component = Qt.createQmlObject("import TreeModel.com 1.0; Filtering { id: car_" +  Randomnumber + "; }",
//                                               you);
//        var Randomnumber1 = Math.random().toString(36).substr(2, 5);
//        var delegateInstance = Qt.createQmlObject("Delegate { id: car_" +  Randomnumber1 + "; }",
//                                               you);
//        var   sprite = delegateInstance.createObject(split,{test:component})

//    }
//    }
    onClosing: {
        myClass.log()

    }

    width: 1920
    height: 1024
    visible: true
    title: qsTr("Hello World")




SplitView{
anchors.fill:parent
id:tes
orientation: Qt.Horizontal
handle: Rectangle {
        implicitWidth: 4
        implicitHeight: 4
        color: SplitHandle.pressed ? "#81e889"
            : (SplitHandle.hovered ? Qt.lighter("#c2f4c6", 1.1) : "#c2f4c6")
}
SplitView{
    id:split

    Layout.preferredWidth: parent.width / 2
            Layout.fillHeight: true
    orientation: Qt.Vertical

    handle: Rectangle {
            implicitWidth: 4
            implicitHeight: 4
            color: SplitHandle.pressed ? "#81e889"
                : (SplitHandle.hovered ? Qt.lighter("#c2f4c6", 1.1) : "#c2f4c6")
    }



}
}



}
Component.onCompleted: {
    console.log(you.settings.arrayOfWindows)

    for(var i =0;i<you.settings.arrayOfWindows.length;i++){
    var component = Qt.createComponent("WindowComponent.qml");
                var window    = component.createObject(you);
    you.array.push(window)
        console.log(you.settings.arrayOfWindows[i].x)

        window.x = you.settings.arrayOfWindows[i].x
        window.y = you.settings.arrayOfWindows[i].y
        window.width = you.settings.arrayOfWindows[i].width
        window.height = you.settings.arrayOfWindows[i].height



    console.log(window)
    window.showMaximized();
    }
}
