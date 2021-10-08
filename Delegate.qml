import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls 1.4 as QCY
import QtQuick.Window 2.12
import QtQuick.Dialogs 1.1
import QtQuick.Layouts 1.15
import Qt.labs.qmlmodels 1.0
import QtQuick.Controls.Styles 1.4


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

}

        property alias tree: nodeTree
        property alias ser: search
        property alias test: nodeTree.model
        property bool isMobile: false
        objectName: Math.random().toString(36).substr(2, 5)

        SplitView.minimumHeight: 200
                   SplitView.preferredHeight: parent.height / 2
                   SplitView.minimumWidth: 100
                   SplitView.preferredWidth: parent.width / 4
                   SplitView.maximumWidth: Screen.width
        Column {
            id: layout

            width: parent.width
            height: parent.height
            anchors.fill: parent
            spacing: 0
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

            QCY.TreeView {
                horizontalScrollBarPolicy : Qt.ScrollBarAsNeeded
                verticalScrollBarPolicy: Qt.ScrollBarAlwaysOff


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
                    }

                }
                MessageDialog {
                    id: copyDialog
                    title: "Warning"
                    text: "Infinite recursion detected, the node will not be inserted"
                    onAccepted: {
return;
                    }

                }


                Connections{
                target:sharedModel
                function onRecursionSignal(){
                copyDialog.open();
                }
                }
                QCY.TableViewColumn {
                    id:ou
                        role: "edit"
                        width: viewInstance.isMobile? viewInstance.width:viewInstance.parent.width



                    }
                property var rowHeight: 40
                property var parentIndex: nodeTree.model.parent(
                                              nodeTree.currentIndex) //index

                width:viewInstance.width
                              height: viewInstance.height -search.height
                clip: true


headerVisible: false
//frameVisible:false


                Component.onCompleted: {

                    if(sharedModel.isMobile()){
                            viewInstance.isMobile = true
                            } //TODO


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
                    }  else if ((event.key === Qt.Key_5)
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
                    }  else if ((event.key === Qt.Key_D)
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
                    }  else if ((event.key === Qt.Key_O)
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
                    } else if ((event.key === Qt.Key_M)
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
                    }
                }


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


}

selectByMouse: true

textFormat: TextEdit.PlainText
clip: true
font.pointSize: 18
anchors.leftMargin: 5
text: model.edit

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
                        property int depth: styleData.depth
                        property var conHeight: content.height

                        visible: true
                       height:100
                        implicitWidth: viewInstance.parent.width
                        focus: true
                        clip: true








                        Button {
                            id: dot
                            x:  depth
width:20
background: Rectangle {
                color:  "white"
        }
                            anchors.leftMargin: 100


                            anchors.verticalCenter: parent.verticalCenter

                            Text{
                                id:textDot
                                anchors.fill:parent
                                 text: "⬤"
                                   font.pixelSize:10
                                                     }
onClicked: {
    itemMenu.open();}
                        }




 TextArea {

                           anchors.left: dot.right
anchors.leftMargin: 5
 width: delegateRoot.width  - delegateRoot.x - anchors.leftMargin
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
                                                  font.pointSize: 18
                                                  text: model.edit
                                                  onActiveFocusChanged: {
                                                      if (activeFocus) {

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
console.log("x  " +x)
                                                          console.log("delegateRoot.x  " +delegateRoot.x)

                                                          console.log("width  " +width)
                                                          console.log("width -  " +width)

                                                          console.log("
                                                                delegateRoot.width   " +delegateRoot.width )

                                                         model.edit = text



                                                      }
                                                      if (nodeTree.activeFocus
                                                              && content.activeFocus) {
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
