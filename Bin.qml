//import QtQuick 2.15
//import QtQuick.Controls 2.15
//import QtQuick.Window 2.12
//import QtQuick.TreeView 2.15
////import TreeModel.com 1.0
////import TreeModel.com1 1.0
//import Qt.labs.platform 1.0
//import QtQuick.Layouts 1.11
//import Qt.labs.qmlmodels 1.0
//Component{
//id:tree
//TreeView {

//    id:waaa

//    SplitView.preferredHeight:  parent.height/2
//Shortcut {
//sequence: "Ctrl+E"
//onActivated: myProxy1.saveIndex(waaa.currentModelIndex)
//}

//    width:100
//    styleHints.overlay: "green"
//    styleHints.indent: 25
//    styleHints.columnPadding: 30



//    property var parentIndex: myProxy1.parent(waaa.currentModelIndex)
//    Keys.onDigit3Pressed: {

//        event.accepted = true
//        var test = parentIndex
//        console.log(waaa.currentModelIndex.row)
//      myProxy1.removeRows(waaa.currentModelIndex.row,1,test)//TODO
//}
//    Keys.onDigit4Pressed: {

//        event.accepted = true
//        var test = waaa.currentModelIndex
//        console.log(test)
//      myProxy1.copyRows(0,1,test)//TODO
//}
//    Keys.onDigit2Pressed: {

//        event.accepted = true
//        var test = waaa.currentModelIndex.parent
//        console.log(test)
//      myProxy1.insertRows(waaa.currentModelIndex.row+1,1,test)//TODO
//}
//    Keys.onDigit8Pressed: {

//        event.accepted = true
//        var test = waaa.currentModelIndex
//        console.log(test)
//      myProxy1.saveIndex(test)//TODO
//}
//    Keys.onDigit5Pressed: {

//        event.accepted = true
//        var test = waaa.currentModelIndex
//        console.log(test)
//      myProxy1.insertRows(0,1,test)//TODO
//}
//    model: myProxy1

//    onCurrentIndexChanged: console.log("current index: " + currentIndex
//                                           + " current row: " + currentIndex.row)

//    delegate:


//Component{
//        id:ey

//                                    Rectangle {

//            MouseArea {
//                    anchors.fill: parent


//                    onClicked: {
//                        console.log(waaa.currentIndex)
//                        focus = true

//                        waaa.currentIndex === index;
//                        console.log(waaa.currentIndex)
//                        console.log(index)

//                        waaa.expand(waaa.currentIndex.row)
//                    }
//                }
////                                            TapHandler {
////                                                id:tap1
////                                                onTapped: {
////                                                    var posInTreeView = waaa.mapFromItem(parent, point.position)
////                                                    var row = waaa.rowAtY(posInTreeView.y, true)
////                                                    waaa.currentIndex = waaa.viewIndex(0, row);
////                                                     focus = true
//////                                                    if (tapCount == 1)
//////                                                        waaa.toggleExpanded(row)
////                                                }
////                                            }
//                                        id:newId
//                                        visible:true
//                                        implicitHeight: 50
//                                        implicitWidth: 1920
////                                            focus:true
//                                        property bool hasChildren: TreeView.hasChildren
//                                        property bool isExpanded: TreeView.isExpanded
//                                        property int depth: TreeView.depth

////                                            Component.onCompleted:    {
//                        //                                           var posInTreeView = waaa.mapFromItem(parent, point.position)
//                        //                                           var row = waaa.rowAtY(posInTreeView.y, true)

//                                                                   // myProxy1.enableFilter(true)
////                                                                       if (isExpanded == false)
////                                                                           waaa.expand(tap.row) //TODO
////                                                                   } //TODO: move to c++?
//                                        Keys.onDigit0Pressed: {

//                                            event.accepted = true
//                                            var test = waaa.currentIndex
//                                            console.log(test)
//                                          // mee.insertRows(0,1,test)//TODO
//                        }
//                                        Keys.onDigit1Pressed: {

//                                            event.accepted = true
//                                            var test = waaa.currentModelIndex.row
//                                            console.log("aaa  " + test)
//                                           //mee.insertRows(0,1,test)//TODO
//                        }
//                                        Keys.onUpPressed: {

//                                            event.accepted = true
//                                           // treeview.currentIndex = treeview.viewIndex;
//                                            var test = waaa.mapToModel(waaa.index)
//                                            console.log("aaa " + test)
//                                           //mee.insertRows(0,1,test)//TODO
//                        }

//                                        Text {
//                                            id: indicator1
//                                            x: depth * waaa.styleHints.indent

//                                            color: "black"
//                                            font: waaa.styleHints.font
//                                            text: hasChildren ? (isExpanded ? "▼" : "▶") : ""
//                                            anchors.verticalCenter: parent.verticalCenter


//                                            TapHandler {
//                                                id:tap
//                                                onTapped: {
//                                                    var posInTreeView = waaa.mapFromItem(parent, point.position)
//                                                    var row = waaa.rowAtY(posInTreeView.y, true)
//                                                    waaa.currentIndex = waaa.viewIndex(0, row);
//                                                    if (tapCount == 1)
//                                                        waaa.toggleExpanded(row)
//                                                }
//                                            }
//                                        }
//                                        Text {
//                                                id: ball1
//                                                x: depth * waaa.styleHints.indent +indicator1.width*1.5
//                                                color: "black"
//                                               // anchors.left :  indicator1
//                                                anchors.leftMargin:100
//                                                font: waaa.styleHints.font
//                                                text: "⬤"
//                                                anchors.verticalCenter: parent.verticalCenter
//                                            }
//                                        TextArea {

//                                            focus:true
//                                            signal qmlSignal(string msg)
//                                            wrapMode:TextEdit.Wrap
//                                            textFormat: TextEdit.MarkdownText
//                                            clip:true
//                                            font.pointSize: 18
//                                            x: indicator1.x + Math.max(waaa.styleHints.indent, indicator1.width * 1.5)
//                                           text: edit
//                                            onEditingFinished: {edit = text
//                                            qmlSignal ("text");
//                                            }
//                                            onQmlSignal: {
//                                                    console.log(msg)
//                                                }

//                                        }
//                               }
//}



//}


//                }





//////*

////main.qml
////import QtQuick 2.15
//import QtQuick.Controls 2.15
//import QtQuick.Window 2.12
//import QtQuick.TreeView 2.15
////import TreeModel.com 1.0
////import TreeModel.com1 1.0
//import Qt.labs.platform 1.0
//import QtQuick.Layouts 1.11
//import Qt.labs.qmlmodels 1.0

//ApplicationWindow {
//    width: 1920
//    height: 1024
//    visible: true
//    title: qsTr("Hello World")

//SplitView{
//    anchors.fill:parent
//    orientation: Qt.Vertical

//    handle: Rectangle {
//            implicitWidth: 4
//            implicitHeight: 4
//            color: SplitHandle.pressed ? "#81e889"
//                : (SplitHandle.hovered ? Qt.lighter("#c2f4c6", 1.1) : "#c2f4c6")
//    }
////    spacing:2
//    TreeView {

//        id:treeview
////        SplitView.fillHeight : true
//        SplitView.preferredHeight:  parent.height/2
////SplitView.minimumHeight:200
////implicitHeight: 400
////SplitView.maximumHeight: 600
////      height: 350
//        width:100
////        MouseArea {
////                anchors.fill: parent
////                Keys.onDigit8Pressed: {
////                    ld.active = !ld.active
////                }
////           }
//        styleHints.overlay: "green"
//        styleHints.indent: 25
//        //styleHints.columnPadding: 30
//      // anchors.fill: parent //TODO: remove in column view
//        property var parentIndex: myProxy.parent(treeview.currentModelIndex)
////       Keys.onDigit9Pressed: {
////                              ld.active = !ld.active
////                          }
//        Keys.onDigit3Pressed: {

//            event.accepted = true
//            var test = parentIndex
//            console.log(treeview.currentModelIndex.row)
//          myProxy.removeRows(treeview.currentModelIndex.row,1,test)//TODO
//}
//        Keys.onDigit4Pressed: {

//            event.accepted = true
//            var test = treeview.currentModelIndex
//            console.log(test)
//          myProxy.copyRows(0,1,test)//TODO
//}
//        Keys.onDigit2Pressed: {

//            event.accepted = true
//            var test = treeview.currentModelIndex
//            console.log(test)
//          myProxy.insertRows(0,1,test)//TODO
//}
//        Keys.onDigit8Pressed: {

//            event.accepted = true
//            var test = treeview.currentModelIndex
//            console.log(test)
//          myProxy.saveIndex(test)//TODO
//}
//        Keys.onDigit5Pressed: {

//            event.accepted = true
//            var test = treeview.currentModelIndex
//            console.log(test)
//          //mee.insertRows(0,1,test)//T-ODO
//}
//        model: myProxy



//        delegate: Rectangle {
////            TapHandler {
////                id:tap2
////                onTapped: {
////                    var posInTreeView = treeview.mapFromItem(parent, point.position)
////                    var row = treeview.rowAtY(posInTreeView.y, true)
////                    treeview.currentIndex = treeview.viewIndex(0, row);
//////                     focus = true
//////                                                    if (tapCount == 1)
//////                                                        waaa.toggleExpanded(row)
////                }
////            }

//                id:hey
//                implicitWidth: 1920
//                implicitHeight: 50
//                color: "steelblue"
//                focus:true
//                property bool hasChildren: TreeView.hasChildren
//                property bool isExpanded: TreeView.isExpanded
//                property int depth: TreeView.depth
////                Component.onCompleted:    {
//////                                           var posInTreeView = waaa.mapFromItem(parent, point.position)
//////                                           var row = waaa.rowAtY(posInTreeView.y, true)

////                                            myProxy.enableFilter(true)

////                                       }
////                MouseArea {
////                                anchors.fill: parent
////                                onClicked: treeview.currentIndex = index
////                            }
//                Keys.onDigit0Pressed: {

//                    event.accepted = true
//                    var test = treeview.currentIndex
//                    console.log(test)
//                  // mee.insertRows(0,1,test)//TODO
//}
//                Keys.onDigit1Pressed: {

//                    event.accepted = true
//                    var test = treeview.currentModelIndex.row
//                    console.log("aaa  " + test)
//                   //mee.insertRows(0,1,test)//TODO
//}
//                Keys.onUpPressed: {

//                    event.accepted = true
//                   // treeview.currentIndex = treeview.viewIndex;
//                    var test = treeview.mapToModel(treeview.index)
//                    console.log("aaa " + test)
//                   //mee.insertRows(0,1,test)//TODO
//}

//                Text {
//                    id: indicator
//                    x: depth * treeview.styleHints.indent

//                    color: "black"
//                    font: treeview.styleHints.font
//                    text: hasChildren ? (isExpanded ? "▼" : "▶") : ""
//                    anchors.verticalCenter: parent.verticalCenter


//                    TapHandler {
//                        onTapped: {
//                            var posInTreeView = treeview.mapFromItem(parent, point.position)
//                            var row = treeview.rowAtY(posInTreeView.y, true)
//                            console.log(row)
//                            treeview.currentIndex = treeview.viewIndex(0, row);
//                            if (tapCount == 1)
//                                treeview.toggleExpanded(row)
//                        }
//                    }
//                }
//                Text {
//                        id: ball
//                        x: depth * treeview.styleHints.indent +indicator.width*1.5
//                        color: "black"
//                        //anchors.left :  indicator
//                        //anchors.leftMargin:100
//                        font: treeview.styleHints.font
//                        text: "⬤"
//                        anchors.verticalCenter: parent.verticalCenter
//                    }
//                TextArea {

//                    focus:true

//                    wrapMode:TextEdit.Wrap
//                    textFormat: TextEdit.MarkdownText
//                    clip:true
//                    font.pointSize: 18
//                    x: indicator.x + Math.max(treeview.styleHints.indent, indicator.width * 1.5)
//                    text: edit //TODO adapt for proxies
//                    onEditingFinished: edit = text
//                }
//        }

//    }


////        Loader {
////            id: ld

////            sourceComponent: comp
////            active: false
////            //anchors.fill: parent
////        }

////        Component {
////             id: comp





//    TextArea{
//    id:search
//    signal info(string msg)
//    objectName: "search"
////    anchors.top: waaa.bottom
//    SplitView.fillHeight : true
//    placeholderText: "Search here"
////    SplitView.minimumHeight:200
////   implicitHeight: 400
////    SplitView.maximumHeight: 600

//    focus:true
//    onTextChanged: {
//        //myProxy1.enableFilter(true)
//        myProxy1.setBool(true)
//        waaa.model.setQuery(text)


//    }

//    }
////    onEditingFinished:

//}




//}

//// ...
////    Shortcut {
////    sequence: "Ctrl+G"
////    onActivated:  {
////        var component = Qt.createQmlObject("import TreeModel.com 1.0; Filtering { id: car_1; }",
////                                               you);
//////        var source1 = source.createObject(you)
////waaa.height = waaa.height/2
////        var   sprite = trie.createObject(split,{model:component})


////    }
////    }
////    Shortcut {
////    sequence: "Ctrl+D"
////    onActivated:  {
////        var component = Qt.createQmlObject("import TreeModel.com 1.0; Filtering { id: car_1; }",
////                                               you);
//////        var source1 = source.createObject(you)

////        var   sprite = trie.createObject(tes,{model:component})


////    }
////    }*/

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
    id:newId1
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
        onEditingFinished: {edit = text
        qmlSignal ("text");
        }
        onQmlSignal: {
                console.log(msg)
            }

    }
}

//
function expandAll(ind) {
//            if(waaa.model.rowCount(ind)){
//waaa.expandModelIndex(ind)
//            }
            for(var i=0; i < waaa.model.rowCount(ind); i++) {
//                        if(ind.parent.valid){
//                        waaa.expandModelIndex(ind)
//                        }
                var index = waaa.model.index(i,0,ind)


                 waaa.expandModelIndex(index)
                 var indexAfter = waaa.model.index(i,0,ind)
                 console.log("ind "+ ind)
                 console.log("parent "+ waaa.model.index(0,0,ind).parent)
                 console.log("waaa.model.rowCount(ind) "+ waaa.model.rowCount(ind))
                 console.log("before ind " + waaa.model.rowCount(ind))
                console.log("before index " + waaa.model.rowCount(index))
                console.log("index "+ index)
                console.log("waaa.model.index(i,0,ind) "+ waaa.model.index(i,0,ind))
                 console.log("data ind "+ waaa.model.data(ind ))
                console.log("data index "+ waaa.model.data(index ))

                if (waaa.model.rowCount(index)!==0){
                    console.log(waaa.model.rowCount(index))
                    expandAll(index)
                }




           }

return;

}




_INVOKABLE void TreeModel::deserialize( TreeItem  *node ,QDataStream &stream, bool check){
if(!check){ // if inserted node is not copied
    stream >> node;}
else{ //if node is copied
//     clone = new TreeItem(nullptr);
   stream >> clone;
    for(int i = 0;i < node->childItems->size();i++){
        stream >> clone;
    clone->itemData->clear();
//        clone->result = !clone->result;
    }
    return;
    //    node->childItems->clear(); //delete(onle from container?) constructed children. Does info get lost when reconstructing? e.g. when there are copied nodes in children?
//    node->parents->clear(); //TODO

}
map.insert(node->id,node);
//     map.insert(node->id,node);
    if((node->temp.size() >1)&& (!check)){ //temp stores id's of parents.if more than 1 then node is copied
     for(int i = 0; i < node->temp.size();i++){
//         auto p = node->temp[i];

//     auto v = map.key(node->parentItem);
//     auto f1 = map.value(container.key(node->id));
//         if(node->temp[i] != map.key(node->parentItem)){ //TODO what if copies are placed in same row? //if one of parents id's doesn't match parentItem/

//             container.insert(node->id,node->temp[i]); //container has id's of items linked to their parents' items

//         }
          //TODO what if copies are placed in same row? //if one of parents id's doesn't match parentItem/

             container.insert(node->id,node->temp[i]); //container has id's of items linked to their parents' items ids
//probable dont need to check for parent now. Likely caused bugs of other otems had item's parent as a parent

     }
     }


if(node->numberOfChildren){
//    auto l = map.value(container.key(node->id))->position;
    for(int i = 0; i < node->numberOfChildren;i++){
//         auto r = map.value(container.key(node->id));
//        QVector<QUuid> arrkeys;
//        for( auto element:container.keys()){
//            if( container.value(element) == node->id){
//                arrkeys.append(container.value(element));

//            }
//        }
//auto values = container.values();
        if(container.key(node->id) == QUuid()){ //if item is a not parent of a copied item
 deserialize(node->insertChildren2(i,1,0),stream);
        }
        else{
//            bool result = false;
//           arrkeys.f
       if (map.value(container.key(node->id))->position[0] != i){
 deserialize(node->insertChildren2(i,1,0),stream);
        }
        else{//if item is not a parent of a copied item
//            auto k = container.key(node->id);
            auto f = map.value(container.key(node->id));

map.value(container.key(node->id))->position.remove(0);

container.remove(container.key(node->id),node->id); //TODO

//            node->insertChildren1(i,1,0,f);
            deserialize( node->insertChildren1(i,1,0,f),stream,true);


        }
        }

    }
//    if(!check){
//        for(int i = 0;i<node->childItems->size();i++){
//            (*node->childItems.get())[i] = clone;

//        }
//    }
}
return;
}
Q_INVOKABLE void TreeModel::deserialize( TreeItem  *node ,QDataStream &stream, bool check){
 if(!check){ // if inserted node is not copied
    stream >> node;
    map.insert(node->id,node);
    if((node->temp.size() >1)&& (!check)){ //temp stores id's of parents.if more than 1 then node is copied
     for(int i = 0; i < node->temp.size();i++){
 if(node->temp[i] != map.key(node->parentItem)){
    container.insert(node->id,node->temp[i]);
    }//container has id's of items linked to their parents' items ids
     }
     if(!node->position.isEmpty()){
        node->position.remove(0);
     }
     }}
else{
    //if node is copied
//     clone = node;
   stream >> node;
   node->childItems->clear();
//   QVector<QVariant> data(columns);
//   TreeItem *item = new TreeItem(data, this);
//   *item = *parent;
//   item->setParent(this);
//   childItems->insert(position, item);

//return (*childItems.get())[position];
//    for(int i = 0;i < node->childItems->size();i++){
//        stream >> clone;
////    clone->itemData->clear();
//        clone->result = !clone->result;
//    }
//    return;

}
for(int i = 0; i < node->numberOfChildren;i++){
    if(container.key(node->id) == QUuid()){ //if item is a not parent of a copied item

deserialize(node->insertChildren2(i,1,0),stream);
    }
    else{
  if(  map.value(container.key(node->id)))
  {



auto score = map.value(container.key(node->id));

     if (map.value(container.key(node->id))->position[0] != i){
auto e = map.value(container.key(node->id))->position[0];
deserialize(node->insertChildren2(i,1,0),stream);
    }

     else if (map.value(container.key(node->id))->position[0] == i){//if item is not a parent of a copied item

        auto f = map.value(container.key(node->id)); //copy constructor?
        auto o = map.value(container.key(node->id))->position[0];
        map.value(container.key(node->id))->position.remove(0);

        container.remove(container.key(node->id),node->id); //TODO


        deserialize( node->insertChildren1(i,1,0,f),stream,true);


    }
  }
}
}


    Q_INVOKABLE void TreeModel::serialize( TreeItem  *node ,QDataStream &stream){
        if ((*node->parents.get()).size() >1){ //check if item has more than 1 parent; al
        for(int i = 0; i < (*node->parents.get()).size();i++){
            if ((*node->parents.get())[i] != nullptr){ //check for nullptr
           node->temp.append((*node->parents.get())[i]->id);
            }
        }
        }
        if (node->parents->size() >1){
    //        for(int i = 0;i< (*node->parents.get())[i]->childItems )
    //        if((node->parentItem->childItems.get()[i])
    //node->position.append(node->parentItem->childItems->indexOf(node));
    for(int i = 0; i < node->parents->size();i++){
        for(int j = 0;j< (*node->parents.get())[i]->childItems->size();j++){
    //        auto temp =  (*(*node->parents.get())[i]);
    //        auto n = *(*temp.childItems.get())[j];
    //        auto t1 = (*node->parents.get())[i]->childItems->size();
    //         QVector<TreeItem*> pi2 = (temp.childItems.get()[j]);
    //        TreeItem* pi = (temp.childItems.get()[j][j]);
    //        auto t = *node;
    //        auto iu = temp.childItems.get()[j][0];
    ////        if( temp.childItems.get()[j][0] == node){
    //      auto r =   *(temp.childItems.get()[0][j]);
            if( (*(*(*(*node->parents.get())[i]).childItems.get())[j]) == *node){
    //            auto copy = (*temp.childItems.get())[j];
    //            auto copy = temp.childItems.get()[j][0];
    //             TreeItem&  copy = (*(*(*(*node->parents.get())[i]).childItems.get())[j]);
    //            auto p = (*node->parents.get())[i]->childItems->indexOf(&copy);
                node->position.append((*node->parents.get())[i]->childItems->indexOf(&(*(*(*(*node->parents.get())[i]).childItems.get())[j])));

    //    if((*node->parents.get())[i]->parentItem !=nullptr){
    //             node->position.append((*node->parents.get())[i]->parentItem->childItems->indexOf(&*(*node->parents.get())[i]));
    //}
    //    if((*node->parents.get())[i]->parentItem !=nullptr){
    //             node->position.append((*node->parents.get())[i]->childItems->indexOf(&*(*node->parents.get())[i]));
    //}
    //    }
    //auto u = (*node->parents.get())[i]->childItems->indexOf((*node->parents.get())[i]->childItems.);
    //auto k = (*node->parents.get())[i];

    //    node->position.append((*node->parents.get())[i]->childItems->indexOf((*node->parents.get())[i])); //
            }
        }
    }
        }

    node->numberOfChildren = node->childCount();
        stream << *node;

    if(node->childCount()){ //TODO replace with numberOfChildren?
        for(int i = 0; i < node->childCount();i++){
            TreeItem* childNode = (*node->childItems.get())[i];

            serialize(childNode,stream);

        }
    }

    return;
    }
