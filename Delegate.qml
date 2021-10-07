import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls 1.4 as QCY


import QtQuick.Window 2.12
//import QtQuick.TreeView 2.15
//import Qt.labs.platform 1.0
import QtQuick.Dialogs 1.1
import QtQuick.Layouts 1.15
import Qt.labs.qmlmodels 1.0
//import Qt.labs.platform 1.1
import QtQuick.Controls.Styles 1.4
//import QtQuick.VirtualKeyboard 2.15
//import QtQuick.VirtualKeyboard.Styles 2.15
//import QtQuick.VirtualKeyboard.Settings 2.15

Component {

    Item {

        Menu {
                 id:itemMenu



                 MenuItem { text: "Insert a node"
                 onTriggered: {
                     var position = sharedModel.position(
                                 nodeTree.model.mapToSource(
                                     nodeTree.currentIndex))
                     sharedModel.insertRows(
                                 position + 1, 1, nodeTree.model.mapToSource(
                                     nodeTree.currentIndex).parent) //TODO

                 }
                 }
                 MenuItem { text: "Insert a node as a child"
                 onTriggered: {
                     sharedModel.insertRows(
                                 0, 1, nodeTree.model.mapToSource(
                                     nodeTree.currentIndex)) //TODO
                     nodeTree.expand(nodeTree.currentIndex)

                 }
                 }
                 MenuItem { text: "Copy the id of a node"
                 onTriggered: {
                     var id = sharedModel.getId(
                                 nodeTree.model.mapToSource(
                                     nodeTree.currentIndex))

                     search.forceActiveFocus()

                                             search.append(id)
                 }}

                 MenuItem { text: "Copy a node"
                 onTriggered: {
                     sharedModel.saveIndex(
                                                        nodeTree.model.mapToSource(
                                                            nodeTree.currentIndex)) //TODO
                 }
                 }

                 MenuItem { text: "Insert a copy as a child"
                 onTriggered: {

                     var position = sharedModel.position(
                                 nodeTree.model.mapToSource(
                                     nodeTree.currentIndex))

                     sharedModel.copyRows(
                                 position + 1, 1, nodeTree.model.mapToSource(
                                     nodeTree.currentIndex).parent,
                                 sharedModel.getLastIndex()) //TODO
                 }
                 }
                 MenuItem { text: "Insert a child copy"
                 onTriggered: {
                     sharedModel.copyRows(0, 1, nodeTree.model.mapToSource(
                                          nodeTree.currentIndex),
                                      sharedModel.getLastIndex()) //TODO
                     nodeTree.expand(nodeTree.currentIndex)

                 }
                 }
                 MenuItem { text: "Delete a node"
                 onTriggered: {
                     var position = sharedModel.position(
                                 nodeTree.model.mapToSource(
                                     nodeTree.currentIndex))

                     sharedModel.removeRows(
                                 position, 1, nodeTree.model.mapToSource(
                                     nodeTree.currentIndex).parent) //TODO
                 }
                 }

                 Menu { title: "Load the storage"
cascade: true
                         MenuItem { text: "Load the storage(JSON)"
                         onTriggered: {
                sharedModel.loadFileJSON();

                         }
                         }
                         MenuItem { text: "Load the storage(.dat)"
                             onTriggered: {
                             sharedModel.loadFile();
                                      }
                                     }
                         MenuItem { text: "Load the storage(local)"
                             onTriggered: {
                          sharedModel.loadFileIDBFS();
                                      }
                                     }



                 }
                 Menu { title: "Save the storage"
        cascade: true
        MenuItem { text: "Save the storage(JSON)"
        onTriggered: {
        sharedModel.saveJSON();
        }
        }
        MenuItem { text: "Save the storage(.dat)"
        onTriggered: {
        sharedModel.save();
        }
        }

                                 MenuItem { text: "Save the storage(local)"
                                     onTriggered: {
        sharedModel.saveIDBFS();                                     }



                         }
                         }



                 MenuItem { text: "Open a new pane"
                 onTriggered: {


        //                     var Randomnumber = Math.random().toString(36).substr(2, 5)
        //                                var component = Qt.createQmlObject(
        //                                            "import TreeModel.com 1.0; Filtering { id: car_" + Randomnumber + "; }",
        //                                            viewInstance.parent.parent.root)
        //                                var Randomnumber1 = Math.random().toString(36).substr(2, 5)
        //                                var delegateInstance = Qt.createQmlObject(
        //                                            "Delegate { id: car_" + Randomnumber1 + "; }", viewInstance.parent.parent.root)

        //                                var ut = delegateInstance.createObject(viewInstance.parent.parent, {
        //                                                                           "test": component
        //                                                                       })
                    viewInstance.parent.parent.root.newPane();
                 }
                 }
                 MenuItem { text: "Close a pane"
                               onTriggered: {
                                   viewInstance.destroy()

                               }
                               }
                 Menu { title: "Other actions"
        cascade: true
        MenuItem { text: "Mark as a template"
        onTriggered: {

            sharedModel.acceptsCopies(nodeTree.model.mapToSource(
                                                            nodeTree.currentIndex),
                                                        false)
        }
        }
        MenuItem { text: "Unmark as a template"
        onTriggered: {
            sharedModel.acceptsCopies(nodeTree.model.mapToSource(
                                                              nodeTree.currentIndex),
                                                          true)
        }
        }
        MenuItem { text: "Insert a detached node"
        onTriggered: {



            sharedModel.copyRows(0, 1, nodeTree.model.mapToSource(
                                 nodeTree.currentIndex),
                             sharedModel.getLastIndex(),true) //TODO
            nodeTree.expand(nodeTree.currentIndex)
        }
        }
                         }



             }
        id: viewInstance
Component.onCompleted: {
//    if(sharedModel.isMobile()){
//                                isMobile = true
//                                }
}
//width:parent.width
//height:parent.height
        property alias tree: nodeTree
        property alias ser: search
        property alias test: nodeTree.model
        property bool isMobile: false
        objectName: Math.random().toString(36).substr(2, 5)
//Layout.fillWidth:true
//         Layout.minimumHeight: 200
//         Layout.preferredHeight: parent.height / 2
//         Layout.minimumWidth: 100
//         Layout.preferredWidth: parent.width / 4
//         Layout.maximumWidth: 1000
        SplitView.minimumHeight: 200
                   SplitView.preferredHeight: parent.height / 2
                   SplitView.minimumWidth: 100
                   SplitView.preferredWidth: parent.width / 4
                   SplitView.maximumWidth: Screen.width

        Keys.onPressed: {
           /* if ((event.key === Qt.Key_W)
                    && (event.modifiers & Qt.ControlModifier)
                    && (event.modifiers & Qt.ShiftModifier)) {
                root.arrayOfWindows.length === 0

                var serializationWindowsArray = []
                for (var i = 0; i < root.array.length; i++) {

                    var windowData = [root.array[i].x, root.array[i].y, root.array[i].width, root.array[i].height]

                    serializationWindowsArray.push(windowData)

                    for (var j = 0; j < root.array[i].viewArray.length; j++) {

                        var viewData = [root.array[i].viewArray[j].x, root.array[i].viewArray[j].y, root.array[i].viewArray[j].width, root.array[i].viewArray[j].height, root.array[i].viewArray[j].ser.text]
                        serializationWindowsArray[i].push(viewData)
                    }
                }

                for (var i = 0; i < root.array.length; i++) {
                    root.arrayOfWindows.push((serializationWindowsArray[i]))
                }
                root.settings.windows = root.arrayOfWindows
                sharedModel.save()
                Qt.quit()
                return
            } *//*else if ((event.key === Qt.Key_W)
                       && (event.modifiers & Qt.ControlModifier)) {
                // Delete view Alt D
                viewInstance.destroy()
                return
            }*/
        }

//        Component.onDestruction: {
//            for (var i = 0; i < parent.parent.root.viewArray.length; i++) {
//                if (viewInstance.objectName.toString(
//                            ) === parent.parent.root.viewArray[i].objectName.toString(
//                            )) {
//                    parent.parent.root.viewArray.splice(i, 1)
//                    if (parent.parent.root.viewArray.length === 0) {
//                        parent.parent.root.destroy()
//                    }
//                    break
//                }
//            }
//        }

        Column {
            id: layout

            width: parent.width
            height: parent.height
            anchors.fill: parent
            spacing: 0
//            Button{
//                id:button
//            width: viewInstance.width
//            height:100
//            text: "Save"
//                     onClicked: {
//                         sharedModel.save()


//                     }

//            }
//            Button{
//                id:button1
//            width: viewInstance.width
//            height:100
//            text: "Load"
//                     onClicked: {
//                         sharedModel.loadFile();


//                     }

//            }

            TextArea {
                id: search

                width: viewInstance.width
                wrapMode: "WrapAnywhere"
                selectByMouse: true
                selectionColor: "#3399FF"
                selectedTextColor: "white"
//                height:30
                clip: true
                objectName: "search"
                placeholderText: "Find"
                onSelectedTextChanged:  {

                    if(selectedText.length >0&&viewInstance.isMobile){

                        findSelectionMenu.x = (viewInstance.width) / 3
                                    findSelectionMenu.y = (viewInstance.height ) / 2
                    findSelectionMenu.open()
                    }
                }


                Keys.onEscapePressed: {
                    var posInTreeView = mapToItem(nodeTree, 0, 0)
                    var row = nodeTree.rowAtY(posInTreeView, true)
                    nodeTree.currentIndex = nodeTree.viewIndex(0, row)
                    nodeTree.itemAtModelIndex(
                                nodeTree.currentIndex).item.forceActiveFocus()
                }

                onTextChanged: {
                    nodeTree.model.setQuery(text)
//                    sharedModel.save()


                }
                Menu {
                         id:findSelectionMenu



                         MenuItem { text: "Copy"
                         onTriggered: {

        search.copy();
                         }
                         }
                         MenuItem { text: "Paste"
                         onTriggered: {

        search.paste();
                         }
                         }
                         MenuItem { text: "Cut"
                         onTriggered: {

        search.cut();
                         }
                         }
                }
            }


//    anchors.FILL:parent


            QCY.TreeView {
                horizontalScrollBarPolicy : Qt.ScrollBarAsNeeded
                verticalScrollBarPolicy: Qt.ScrollBarAlwaysOff
//                x: -hbar1.position * width
//                   y: -vbar1.position * height
//                ScrollBar {
//                      id: vbar1
//                      hoverEnabled: true
//                      active: hovered || pressed
//                      orientation: Qt.Vertical
//                      size: frame.height / content.height
//                      anchors.top: parent.top
//                      anchors.right: parent.right
//                      anchors.bottom: parent.bottom
//                  }

//                  ScrollBar {
//                      id: hbar1
//                      hoverEnabled: true
//                      active: hovered || pressed
//                      orientation: Qt.Horizontal
//                      size: frame.width / content.width
//                      anchors.left: parent.left
//                      anchors.right: parent.right
//                      anchors.bottom: parent.bottom
//                  }
//                MouseArea {
//                    id: pos
//                                                onClicked: mouse.accepted = false
//                                                onPressAndHold: mouse.accepted = false
//                                                onDoubleClicked: mouse.accepted = false
//                                                onPositionChanged: mouse.accepted = false
//                                                onReleased: mouse.accepted = false
//                                                onPressed: mouse.accepted = false
//                    anchors.fill: parent
//                    hoverEnabled: true
//                    onWheel: {
////                        event.accepted = true
//                        if (wheel.modifiers & Qt.ShiftModifier) {
//                            if (wheel.angleDelta.y > 0) {
//                                hbar1.increase()
//                            } else if (wheel.angleDelta.y < 0) {
//                                hbar1.decrease()
//                            }
//                        } else if (wheel.angleDelta.y < 0) {

//                            vbar1.increase()
//                        } else if (wheel.angleDelta.y > 0) {
//                            vbar1.decrease()
//                        }
//                    }
//                }
                id: nodeTree
                 //TODO should be false by default
                property int  currentRow
                property int  coHeight

                onCoHeightChanged: {
                cHeight(coHeight,currentRow)}
signal cHeight(var height,var row)

                MessageDialog {
                    id: deleteDialog1
                    title: "Warning"
                    text: "Are you sure you want to delete the selected node? Children nodes will also be deleted"
                   modality:Qt.ApplicationModal
                    onAccepted: {
                        var position = sharedModel.position(
                                    nodeTree.model.mapToSource(
                                        nodeTree.currentIndex))

                        sharedModel.removeRows(
                                    position, 1, nodeTree.model.mapToSource(
                                        nodeTree.currentIndex).parent) //TODO
//                        deleteDialog.close()
                    }

//                    standardButtons: StandardButton.Ok | StandardButton.Close
                }
                MessageDialog {
                    id: copyDialog
                    title: "Warning"
                    text: "Infinite recursion detected, the node will not be inserted"
                    onAccepted: {
return;
                    }

//                    standardButtons: StandardButton.Ok | StandardButton.Close
                }
//                MouseArea {
//                    id: pos
//                                                onClicked: mouse.accepted = false
//                                                onPressAndHold: mouse.accepted = false
//                                                onDoubleClicked: mouse.accepted = false
//                                                onPositionChanged: mouse.accepted = false
//                                                onReleased: mouse.accepted = false
//                                                onPressed: mouse.accepted = false
//                    anchors.fill: parent
////                    hoverEnabled: true
//                    onWheel: {
////                        event.accepted = true

//                        if (wheel.modifiers & Qt.ShiftModifier) {
//                            if (wheel.angleDelta.y > 0) {
//                                hbar.increase()
//                            } else if (wheel.angleDelta.y < 0) {
//                                hbar.decrease()
//                            }
//                        } else if (wheel.angleDelta.y < 0) {

//                            vbar.increase()
//                        } else if (wheel.angleDelta.y > 0) {
//                            vbar.decrease()
//                        }
//                    }fis
//                }
                Connections{
                target:sharedModel
                function onRecursionSignal(){
                copyDialog.open();
                }
                }
                QCY.TableViewColumn {
                    id:ou
//                        title: "Name"
                        role: "edit"
//                        width: 300
                        width: viewInstance.isMobile? viewInstance.width:viewInstance.parent.width



                    }
                property var rowHeight: 40
//                property var indexNow: nodeTree.currentIndex.row
                property var parentIndex: nodeTree.model.parent(
                                              nodeTree.currentIndex) //index
//                contentHeight: 3000
//                contentWidth: 2000
                width:viewInstance.width
                              height: viewInstance.height -search.height
                clip: true
//                reuseItems: true
//                rowHeightProvider: function (row) {

//                    var array = []
//                    for (var child in nodeTree.contentItem.children) {

//                        if (nodeTree.contentItem.children[i].conHeight) {

//                            array.push(nodeTree.contentItem.children[child].conHeight)
//                        }
//                    }

//                    return nodeTree.contentItem.children[row].conHeight
//                }

headerVisible: false
//frameVisible:false


                Component.onCompleted: {

                    if(sharedModel.isMobile()){
                            viewInstance.isMobile = true
                            } //TODO

//                    var posInTreeView = mapToItem(nodeTree, 0, 0)
//                    var row = nodeTree.rowAtY(posInTreeView, true)
//                    nodeTree.currentIndex = nodeTree.viewIndex(0, 0)
//                    nodeTree.itemAtModelIndex(
//                                nodeTree.currentIndex).forceActiveFocus()
                }

                Keys.onDigit2Pressed: {
                }
                Keys.onPressed: {
                    if ((event.key === Qt.Key_P)
                            && (event.modifiers & Qt.ControlModifier)
                            && (event.modifiers & Qt.ShiftModifier)) {

                             event.accepted = true



                        sharedModel.acceptsCopies(nodeTree.model.mapToSource(
                                                  nodeTree.currentIndex),
                                              true)


                        return
                    } else if ((event.key === Qt.Key_W)
                               && (event.modifiers & Qt.ControlModifier)
                               && (event.modifiers & Qt.ShiftModifier)) {
                        root.arrayOfWindows.length === 0

                        var serializationWindowsArray = []
                        for (var i = 0; i < root.array.length; i++) {

                            var windowData = [root.array[i].x, root.array[i].y, root.array[i].width, root.array[i].height]

                            serializationWindowsArray.push(windowData)


                            for (var j = 0; j < root.array[i].viewArray.length; j++) {

                                var viewData = [root.array[i].viewArray[j].x, root.array[i].viewArray[j].y, root.array[i].viewArray[j].width, root.array[i].viewArray[j].height, root.array[i].viewArray[j].ser.text]
                                serializationWindowsArray[i].push(viewData)
                            }
                        }

                        for (var i = 0; i < root.array.length; i++) {
                            root.arrayOfWindows.push(
                                        (serializationWindowsArray[i]))
                        }
                        root.settings.windows = root.arrayOfWindows
                        sharedModel.save()
                        Qt.quit()
                        return
                    } else if ((event.key === Qt.Key_G)
                               && (event.modifiers & Qt.ControlModifier)
                               && (event.modifiers & Qt.ShiftModifier)) {
                             event.accepted = true
                        allIndeces(nodeTree.currentIndex)

                        return
                    } else if ((event.key === Qt.Key_Q)
                               && (event.modifiers & Qt.ControlModifier)
                               && (event.modifiers & Qt.ShiftModifier)) {

                        for (var i = 0; i < viewInstance.parent.parent.root.viewArray.length; i++) {

                            if (viewInstance.parent.parent.root.viewArray[i].objectName.toString(
                                        ) == viewInstance.objectName.toString(
                                        )) {

                                if ((i - 1) > -1) {
                                    viewInstance.parent.parent.root.viewArray[i - 1].tree.itemAtModelIndex(
                                                viewInstance.parent.parent.root.viewArray[i - 1].tree.currentIndex).item.forceActiveFocus()
                                }
                                break
                            }
                        }
                        return
                    }  else if ((event.key === Qt.Key_B)
                               && (event.modifiers & Qt.ControlModifier)
                               && (event.modifiers & Qt.ShiftModifier)) {
     event.accepted = true
                        //insert new node as a child Ctrl Shift N
                        sharedModel.insertRows(
                                    0, 1, nodeTree.model.mapToSource(
                                        nodeTree.currentIndex)) //TODO
                        nodeTree.expand(nodeTree.currentIndex)

                        return
                    } else if ((event.key === Qt.Key_M)
                               && (event.modifiers & Qt.ControlModifier)
                               && (event.modifiers & Qt.ShiftModifier)) {
                             event.accepted = true
                        //copy node as child Ctrl Shift M



                        sharedModel.copyRows(0, 1, nodeTree.model.mapToSource(
                                             nodeTree.currentIndex),
                                         sharedModel.getLastIndex()) //TODO
                        nodeTree.expand(nodeTree.currentIndex)
                        return
                    } else if ((event.key === Qt.Key_P)
                               && (event.modifiers & Qt.ControlModifier)) {
                             event.accepted = true
                        //acceptsCopies false Ctrl P
                        sharedModel.acceptsCopies(nodeTree.model.mapToSource(
                                                  nodeTree.currentIndex),
                                              false)
                        return
                    } /*else if ((event.key === Qt.Key_S)
                               && (event.modifiers & Qt.ControlModifier)) {
                        event.accepted = true

                        //serialize/save Ctrl S
                        sharedModel.save()
                        return
                    }*/ else if ((event.key === Qt.Key_5)
                               && (event.modifiers & Qt.ControlModifier)) {
                        event.accepted = true
                        //serialize/save Ctrl S
                        if (nodeTree.currentIndex.hasChildren) {
                            nodeTree.currentIndex = nodeTree.model.index(
                                        0, 0, nodeTree.currentIndex)
                        } else {
                            nodeTree.currentIndex = nodeTree.model.index(
                                        nodeTree.currentIndex.row + 1, 0,
                                        nodeTree.currentIndex.parent)
                        }
                        return
                    } else if ((event.key === Qt.Key_E)
                               && (event.modifiers & Qt.ControlModifier)
                               && (event.modifiers & Qt.ShiftModifier)) {
                        // Delete view Alt D
                        viewInstance.destroy()
                        return
                    } /*else if ((event.key === Qt.Key_U)
                               && (event.modifiers & Qt.ControlModifier)
                               && (event.modifiers & Qt.ShiftModifier)) {
                        root.settings.windows = []
                        root.array.length = []

                        Qt.quit()
                    }*/ else if ((event.key === Qt.Key_D)
                               && (event.modifiers & Qt.ControlModifier)) {
     event.accepted = true
                        //remove node Ctrl D
//                        deleteDialog.open()
                        var position = sharedModel.position(
                                    nodeTree.model.mapToSource(
                                        nodeTree.currentIndex))

                        sharedModel.removeRows(
                                    position, 1, nodeTree.model.mapToSource(
                                        nodeTree.currentIndex).parent) //TODO
                        return
                    } /*else if ((event.key === Qt.Key_U)
                               && (event.modifiers & Qt.ControlModifier)) {

                        //remove node Ctrl D
                        hbar.decrease()
                        return
                    }*/ else if ((event.key === Qt.Key_O)
                               && (event.modifiers & Qt.ControlModifier)) {
                             event.accepted = true
var query =">:" + sharedModel.getId(
    nodeTree.model.mapToSource(
        nodeTree.currentIndex))
                        //remove node Ctrl D
                        search.forceActiveFocus()
                        search.clear()
                        search.append(query)
                        return
                    } else if ((event.key === Qt.Key_Q)
                               && (event.modifiers & Qt.ControlModifier)) {

                        //copy a copied node Ctrl A
                        sharedModel.saveIndex(
                                    nodeTree.model.mapToSource(
                                        nodeTree.currentIndex)) //TODO
                        return
                    } else if ((event.key === Qt.Key_U)
                               && (event.modifiers & Qt.ControlModifier)
                               && (event.modifiers & Qt.ShiftModifier)) {


//                        //copy Id to clipboard Ctrl E
//                        sharedModel.getIdToClipboard(
//                                    nodeTree.model.mapToSource(
//                                        nodeTree.currentIndex))
//                        return
                        event.accepted = true

                        var id = sharedModel.getId(
                                    nodeTree.model.mapToSource(
                                        nodeTree.currentIndex))

                        search.forceActiveFocus()

                                                search.append(id)
                                                return
                    } else if ((event.key === Qt.Key_F)
                               && (event.modifiers & Qt.ControlModifier)) {
                        //Ctrl F
                        event.accepted = true

                        search.forceActiveFocus()
                        search.selectAll()
                        return
                    } else if ((event.key === Qt.Key_B)
                               && (event.modifiers & Qt.ControlModifier)) {
                        //Ctrl N insert node
                             event.accepted = true
                        var position = sharedModel.position(
                                    nodeTree.model.mapToSource(
                                        nodeTree.currentIndex))
                        sharedModel.insertRows(
                                    position + 1, 1, nodeTree.model.mapToSource(
                                        nodeTree.currentIndex).parent) //TODO

                        return
                    } /*else if ((event.key === Qt.Key_J)
                               && (event.modifiers & Qt.ControlModifier)) {
                        //Ctrl N insert node
                        var test1 = nodeTree.currentIndex.parent
                        nodeTree.currentIndex
                        return
                    }*/ else if ((event.key === Qt.Key_M)
                               && (event.modifiers & Qt.ControlModifier)) {
                        //Ctrl M copy node
                        event.accepted = true


                        var position = sharedModel.position(
                                    nodeTree.model.mapToSource(
                                        nodeTree.currentIndex))

                        sharedModel.copyRows(
                                    position + 1, 1, nodeTree.model.mapToSource(
                                        nodeTree.currentIndex).parent,
                                    sharedModel.getLastIndex()) //TODO
                    } else if ((event.key === Qt.Key_G)
                               && (event.modifiers & Qt.ControlModifier)) {
     event.accepted = true
                        if(!nodeTree.isExpanded(nodeTree.currentIndex)){
                        nodeTree.expand(nodeTree.currentIndex)
                        }
                        else{
                        nodeTree.collapse(nodeTree.currentIndex)
                        }
//                        nodeTree.toggleModelIndexExpanded(
//                                    nodeTree.currentIndex)
                    }
                }

//                oncurrentIndexChanged: {

//                    if ((!search.focus)) {
//                        if (nodeTree.activeFocus) {
//                            itemAtModelIndex(
//                                        nodeTree.currentIndex).item.forceActiveFocus()
//                        }
//                    }
//                } TODOWASM
                function allIndeces(ind) {

                    nodeTree.expand(ind)
                    for (var i = 0; i < nodeTree.model.rowCount(ind); i++) {
                        nodeTree.expand(ind)
                        var index = nodeTree.model.index(i, 0, ind)

                        nodeTree.expand(index)
                        if (nodeTree.model.rowCount(index) !== 0) {

                            allIndeces(index)
                        }
                    }

                    return
                }
                style: TreeViewStyle {
                        frame: Rectangle {
                            border{
                                color: "white" // color of the border
                            }
                        }
                    }
rowDelegate:Component{
id:pt

Rectangle{

id:ot
border.color: "white"
visible:false
height:box.contentHeight +10


TextArea{
id:box
Connections{
target: nodeTree
function onCHeight(coHeight,row){


if(styleData.row === row ){

ot.height = coHeight +10

}
else{
}
}
}
Keys.onEnterPressed: {
//model.edit = model.edit +"\n"


}
//width: nodeTree.width

selectByMouse: true
//                            selectionColor: "#3399FF"
//                            selectedTextColor: "white"
//objectName: "text"
//                            wrapMode: "WrapAnywhere"
textFormat: TextEdit.PlainText
clip: true
font.pointSize: 18
//anchors.left: dot.right
anchors.leftMargin: 5
text: model.edit
//onTextChanged: {
//    model.edit = text
//}
}
}
}
               itemDelegate: Component {

                    id: delegateComponent

                    Rectangle {
                        Component.onCompleted: {



                        }
                        border.color: "white"
                        id: delegateRoot

                        property alias item: content
                        property alias dot: dot
                        property bool hasFocus
//                        property bool hasChildren: TreeView.hasChildren
//                        property bool isExpanded: TreeView.isExpanded
                        property int depth: styleData.depth
                        property var conHeight: content.height

                        visible: true
                       height:100
//                        implicitHeight: 100
                        implicitWidth: viewInstance.parent.width
                        focus: true
                        clip: true

//                        MouseArea {
//                            anchors.fill: parent
//                            acceptedButtons: Qt.NoButton
//                            hoverEnabled: true
//                            cursorShape: Qt.IBeamCursor
//                            propagateComposedEvents: true
//                            onClicked: mouse.accepted = false
//                            onPressAndHold: mouse.accepted = false
//                            onDoubleClicked: mouse.accepted = false
//                            onPositionChanged: mouse.accepted = false
//                            onReleased: mouse.accepted = false
//                            onPressed: mouse.accepted = false
//                            onEntered: {
//                                if (!search.focus) {
//                                    var posInTreeView = mapToItem(nodeTree, mouseX,
//                                                                  mouseY)

//                                    var row = nodeTree.rowAtY(posInTreeView.y,
//                                                              false)

//                                    nodeTree.currentIndex = nodeTree.mapToModel(
//                                                nodeTree.viewIndex(0, row))
//                                    nodeTree.itemAtModelIndex(
//                                                nodeTree.currentIndex).item.forceActiveFocus()
//                                }
//                            }

//                        }
//                        Text {
//                            id: expandIndicator

////                            x: depth * nodeTree.styleHints.indent + 5
//                            x:  depth +5

//                            color: "black"
////                            font: nodeTree.styleHints.font
////                            text: hasChildren ? (isExpanded ? "▼" : "▶") : ""
//                            text: "▶"

//                            anchors.verticalCenter: parent.verticalCenter

//                            TapHandler {
//                                id: tap
//                                onTapped: {

////                                    var posInTreeView = nodeTree.mapFromItem(
////                                                parent, point.position)
////                                    var row = nodeTree.rowAtY(posInTreeView.y,
////                                                              true)
////                                    nodeTree.currentIndex = nodeTree.viewIndex(
////                                                0, row) //index

//                                    if (tapCount == 1)
//                                        if(!nodeTree.isExpanded(nodeTree.currentIndex)){
//                                        nodeTree.expand(nodeTree.currentIndex)
//                                        }
//                                        else{
//                                        nodeTree.collapse(nodeTree.currentIndex)
//                                        }
//                                }
//                            }
//                        }



                        Button {
                            id: dot

//                            x: depth * nodeTree.styleHints.indent + 15
                            x:  depth
width:20
background: Rectangle {
                color:  "white"
        }

//                            color: "black"
                            anchors.leftMargin: 100


                            anchors.verticalCenter: parent.verticalCenter

                            Text{
                                id:textDot
                                anchors.fill:parent
                                 text: "⬤"
                                   font.pixelSize:10
                                   //                            font: nodeTree.styleHints.font

    Component.onCompleted: {

    }                        }
onClicked: {

    itemMenu.open();}
//                            TapHandler {
//                                id: dotTapHandler

//                                onTapped: {

//                                    if(content.text == "Examples"){
//                                    sharedModel.save()
//                                        return;
//                                    }
//                                    if(content.text == "Tags"){

//                                        sharedModel.loadFile();
//                                        return;
//                                    }

////                                    search.forceActiveFocus();
////                                    search.clear();
////                                    search.append(">:" + sharedModel.getId(
////                                                      nodeTree.model.mapToSource(
////                                                          nodeTree.currentIndex)));
////                                    return;

//                                }
//                            }
                        }


//                            ScrollBar.horizontal: ScrollBar{policy: ScrollBar.AlwaysOn}

 TextArea {

                           anchors.left: dot.right
anchors.leftMargin: 5
 width: delegateRoot.width  - x
//   clip: true

                                                  Menu {
                                                           id:selectionMenu



                                                           MenuItem { text: "Copy"
                                                           onTriggered: {

                                          content.copy();
                                                           }
                                                           }
                                                           MenuItem { text: "Paste"
                                                           onTriggered: {

                                          content.paste();
                                                           }
                                                           }
                                                           MenuItem { text: "Cut"
                                                           onTriggered: {

                                          content.cut();
                                                           }
                                                           }
                                                  }
                                                  id: content
                                                  Keys.onDigit3Pressed: {
                                                  }

                      onSelectedTextChanged:  {

                          if(selectedText.length >0&&viewInstance.isMobile){

                              selectionMenu.x = (viewInstance.width) / 3
                                          selectionMenu.y = (viewInstance.height ) / 2
                          selectionMenu.open()
                          }
                      }
                                                  onContentHeightChanged: {
                                                     nodeTree.currentRow = styleData.row
                                                  nodeTree.coHeight = contentHeight}

                                                  selectByMouse: true
                                                  selectionColor: "#3399FF"
                                                  selectedTextColor: "white"
                                                  objectName: "text"
                                                  wrapMode: TextEdit.WrapAnywhere
                                                  textFormat: TextEdit.PlainText
                      //                            background: Rectangle {
                      //                                            color: itemMenu.activeFocus ? "white" :
                      //                                                     "green"
                      //                                    }


                                                  font.pointSize: 18

                                                  text: model.edit
                                                  onActiveFocusChanged: {
                                                      if (activeFocus) {



                      //                                            Qt.inputMethod.hide(); // hide the keyboard

                      //                                    viewInstance.parent.parent.root.parent.input.active == true

                                                          if (sharedModel.hasMultipleSiblings(
                                                                      nodeTree.model.mapToSource(
                                                                          nodeTree.currentIndex))) {
                                                              textDot.color = "blue"
                                                          }
                                                          if (!sharedModel.acceptsCopies(
                                                                      nodeTree.model.mapToSource(
                                                                          nodeTree.currentIndex))) {
                                                              textDot.color = "green"
                                                          }
                                                      } else {
                      //                                    viewInstance.parent.parent.parent.input.active == false

                                                          textDot.color = "black"
                                                      }
                                                  }


                                                  onTextChanged: {

                                                      if (nodeTree.activeFocus) {

                                                         model.edit = text



                                                      }
                                                      if (nodeTree.activeFocus
                                                              && content.activeFocus) {
                      //                                    nodeTree.forceLayout()
                                                          heightChanged()
                                                          widthChanged()
                                                      }
                                                  }








                                              }

                    }
                }



            }








    }
}
}
