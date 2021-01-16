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
      waaa.model.copyRows(0,1,test)//TODO
}
    Keys.onDigit6Pressed: { //TODO
        var component = Qt.createQmlObject("import TreeModel.com 1.0; Filtering { id: car_1; }",
                                                                                           you);
                                            //        var source1 = source.createObject(you)
                                                    console.log(waaa.SplitView.preferredHeight)
                                            waaa.height = waaa.height/2
                                                    console.log(waaa.SplitView.preferredHeight)
                                                    var   sprite = trie.createObject(split,{model:component,height:waaa.height})
    }
    Keys.onDigit7Pressed: {

        allIndeces(waaa.model.index(0,0).parent)}


    Keys.onDigit2Pressed: {

//        expandAll(waaa.model.index(0,0))
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
                                           + " current row: " + currentIndex.row+ " modelImdex: " + currentModelIndex)


    delegate:



DelegateChooser{
        id:delegateChooser
        role: "enabled"
        DelegateChoice{
            roleValue: "true"
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


                                        Keys.onDigit0Pressed: {

                                            event.accepted = true
                                            var test = waaa.currentIndex
                                            console.log(test)
                                          // mee.insertRows(0,1,test)//TODO
                        }
                                        Keys.onDigit1Pressed: {

                                            event.accepted = true
                                            var test = waaa.currentModelIndex.row
                                            console.log("aaa  " + test)
                                           //mee.insertRows(0,1,test)//TODO
                        }
                                        Keys.onUpPressed: {

                                            event.accepted = true
                                           // treeview.currentIndex = treeview.viewIndex;
                                            var test = waaa.mapToModel(waaa.index)
                                            console.log("aaa " + test)
                                           //mee.insertRows(0,1,test)//TODO
                        }

                                        Text {
                                            id: indicator1
                                            x: 10

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

                                            focus:true

                                            wrapMode:TextEdit.Wrap
                                            textFormat: TextEdit.MarkdownText
                                            clip:true
                                            font.pointSize: 18
                                            x: indicator1.x + indicator1.width * 1.5
                                           text: edit
                                            onTextChanged:  {edit = text

                                            }


                                        }
                               }
    }
        DelegateChoice{
        roleValue: "false"
        Rectangle {



            Component.onCompleted: {
                waaa.expand(waaa.currentModelIndex.row)
//                                        expandModelIndex(waaa.currentModelIndex)
            }

            Shortcut {
            sequence: "Ctrl+D"
            onActivated:  {
                var component = Qt.createQmlObject("import TreeModel.com 1.0; Filtering { id: car_1; }",
                                                       you);


                var   sprite = trie.createObject(tes,{model:component})


            }
            }

            id:newId1
            visible:false
           implicitHeight:  1
            implicitWidth:  1
                focus:true
            property bool hasChildren: TreeView.hasChildren
            property bool isExpanded: TreeView.isExpanded
            property int depth: TreeView.depth
            Text {
                id: indicator12
                x: depth * waaa.styleHints.indent

                color: "black"
                font: waaa.styleHints.font
                text: hasChildren ? (isExpanded ? "▼" : "▶") : ""
                anchors.verticalCenter: parent.verticalCenter


                TapHandler {
                    id:tap3
                    onTapped: {
                        var posInTreeView = waaa.mapFromItem(parent, point.position)
                        var row = waaa.rowAtY(posInTreeView.y, true)
                        waaa.currentIndex = waaa.viewIndex(0, row);
                        if (tapCount == 1)
                            waaa.toggleExpanded(row)
                    }
                }
            }
            Text {
                    id: ball12
                    x: depth * waaa.styleHints.indent +indicator12.width*1.5
                    color: "black"
                   // anchors.left :  indicator1
                    anchors.leftMargin:100
                    font: waaa.styleHints.font
                    text: "⬤"
                    anchors.verticalCenter: parent.verticalCenter
                }
            TextArea {

                focus:true
                signal qmlSignal(string msg)
                wrapMode:TextEdit.Wrap
                textFormat: TextEdit.MarkdownText
                clip:true
                font.pointSize: 18
                x: indicator12.x + Math.max(waaa.styleHints.indent, indicator12.width * 1.5)
               text: edit
               onTextChanged:  {edit = text

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
     allIndeces(waaa.model.index(0,0).parent)


}

}

}
                }




