import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls 1.4 as QCY

//import QtQuick.Window 2.12
//import QtQuick.TreeView 2.15
import Qt.labs.platform 1.0
import QtQuick.Dialogs 1.1
import QtQuick.Layouts 1.15
import Qt.labs.qmlmodels 1.0
import QtQuick.Controls.Styles 1.4

Component {

    Item {

        id: viewInstance
//width:parent.width
//height:parent.height
        property alias tree: nodeTree
        property alias ser: search
        property alias test: nodeTree.model

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
                   SplitView.maximumWidth: 10000

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
                myClass.save()
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
                placeholderText: "Search here"
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
            }

            QCY.TreeView {
                id: nodeTree
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
                        var position = myClass.position(
                                    nodeTree.model.mapToSource(
                                        nodeTree.currentIndex))

                        myClass.removeRows(
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
//                    }
//                }
                Connections{
                target:myClass
                function onRecursionSignal(){
                copyDialog.open();
                }
                }
                QCY.TableViewColumn {
                    id:ou
//                        title: "Name"
                        role: "edit"
//                        width: 300
                        width: viewInstance.parent.width


                    }
                property var rowHeight: 40
//                property var indexNow: nodeTree.currentIndex.row
                property var parentIndex: nodeTree.model.parent(
                                              nodeTree.currentIndex) //index
//                contentHeight: 3000
//                contentWidth: 2000
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
                width: viewInstance.width
                height: viewInstance.height -search.height
//                styleHints.overlay: "green"
//                styleHints.indent: 25
//                styleHints.columnPadding: 30
                Component.onCompleted: {
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
                        myClass.acceptsCopies(nodeTree.model.mapToSource(
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
//console.log("root.array[i] " + root.array[i])
//console.log("root.array[i].viewArray " + root.array[i].viewArray)

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
                        myClass.save()
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
                        myClass.insertRows(
                                    0, 1, nodeTree.model.mapToSource(
                                        nodeTree.currentIndex)) //TODO
                        nodeTree.expand(nodeTree.currentIndex)

                        return
                    } else if ((event.key === Qt.Key_M)
                               && (event.modifiers & Qt.ControlModifier)
                               && (event.modifiers & Qt.ShiftModifier)) {
                             event.accepted = true
                        //copy node as child Ctrl Shift M
                        console.log("ctrl-shift-m")



                        myClass.copyRows(0, 1, nodeTree.model.mapToSource(
                                             nodeTree.currentIndex),
                                         myClass.getLastIndex()) //TODO
                        nodeTree.expand(nodeTree.currentIndex)
                        return
                    } else if ((event.key === Qt.Key_P)
                               && (event.modifiers & Qt.ControlModifier)) {
                             event.accepted = true
                        //acceptsCopies false Ctrl P
                        myClass.acceptsCopies(nodeTree.model.mapToSource(
                                                  nodeTree.currentIndex),
                                              false)
                        return
                    } else if ((event.key === Qt.Key_S)
                               && (event.modifiers & Qt.ControlModifier)) {
                        event.accepted = true

                        //serialize/save Ctrl S
                        myClass.save()
                        return
                    } else if ((event.key === Qt.Key_5)
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
                    } else if ((event.key === Qt.Key_U)
                               && (event.modifiers & Qt.ControlModifier)
                               && (event.modifiers & Qt.ShiftModifier)) {
                        root.settings.windows = []
                        root.array.length = []

                        Qt.quit()
                    } else if ((event.key === Qt.Key_D)
                               && (event.modifiers & Qt.ControlModifier)) {
     event.accepted = true
                        //remove node Ctrl D
//                        deleteDialog.open()
                        var position = myClass.position(
                                    nodeTree.model.mapToSource(
                                        nodeTree.currentIndex))

                        myClass.removeRows(
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
var query =">:" + myClass.getId(
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
                        console.log("gggggg")
                        myClass.saveIndex(
                                    nodeTree.model.mapToSource(
                                        nodeTree.currentIndex)) //TODO
                        return
                    } else if ((event.key === Qt.Key_F)
                               && (event.modifiers & Qt.ControlModifier)
                               && (event.modifiers & Qt.ShiftModifier)) {

//                        console.log("ret")

//                        //copy Id to clipboard Ctrl E
//                        myClass.getIdToClipboard(
//                                    nodeTree.model.mapToSource(
//                                        nodeTree.currentIndex))
//                        return
                        event.accepted = true

                        var id = myClass.getId(
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
                        console.log("ytyyyyyyy")
                        var position = myClass.position(
                                    nodeTree.model.mapToSource(
                                        nodeTree.currentIndex))
                        myClass.insertRows(
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

                        console.log("ctrl-m")

                        var position = myClass.position(
                                    nodeTree.model.mapToSource(
                                        nodeTree.currentIndex))

                        myClass.copyRows(
                                    position + 1, 1, nodeTree.model.mapToSource(
                                        nodeTree.currentIndex).parent,
                                    myClass.getLastIndex()) //TODO
                    } else if ((event.key === Qt.Key_G)
                               && (event.modifiers & Qt.ControlModifier)) {
     event.accepted = true
                        if(!nodeTree.isExpanded(nodeTree.currentIndex)){
                            console.log("ttttt")
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
    console.log("Connections " +styleData.row)

    console.log("coHeight b  " +coHeight)
ot.height = coHeight +10
    console.log("ttttrrrrr " +box.height)

}
}
}
Keys.onEnterPressed: {
//model.edit = model.edit +"\n"
    console.log("before " +contentHeight)
    console.log("after " +contentHeight)

}
width: nodeTree.width
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
//console.log("hhhhhhhhhhhhhhhhh")
//    model.edit = text
//}
}
}
}
               itemDelegate: Component {

                    id: delegateComponent

                    Rectangle {

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
//                                            console.log("ttttt")
//                                        nodeTree.expand(nodeTree.currentIndex)
//                                        }
//                                        else{
//                                        nodeTree.collapse(nodeTree.currentIndex)
//                                        }
//                                }
//                            }
//                        }
                        Text {
                            id: dot

//                            x: depth * nodeTree.styleHints.indent + 15
                            x:  depth

                            color: "black"
                            anchors.leftMargin: 100
                            font.pixelSize:10
//                            font: nodeTree.styleHints.font
                            text: "⬤"
                            anchors.verticalCenter: parent.verticalCenter

                            TapHandler {
                                id: dotTapHandler
                                onTapped: {
                                    search.forceActiveFocus();
                                    search.clear();
                                    search.append(">:" + myClass.getId(
                                                      nodeTree.model.mapToSource(
                                                          nodeTree.currentIndex)));
                                    return;
//                                    var posInTreeView = nodeTree.mapFromItem(
//                                                parent, point.position)
//                                    var row = nodeTree.rowAtY(posInTreeView.y,
//                                                              true)
//                                    nodeTree.currentIndex = nodeTree.viewIndex(
//                                                0, row) //index

//                                    if (tapCount == 1)

//                                        search.forceActiveFocus()
//                                    search.selectAll()
//                                    search.append(
//                                                ">:" + myClass.getId(
//                                                    nodeTree.model.mapToSource(
//                                                        nodeTree.currentIndex)))
                                }
                            }
                        }

                        TextArea {
                            id: content
//style: TextAreaStyle{
//Rectangle{
//border.color:"white"
//}
//}
//backgroundVisible :false
                            onContentHeightChanged: {
                               nodeTree.currentRow = styleData.row
                            nodeTree.coHeight = contentHeight}
                            width: delegateRoot.width
                            selectByMouse: true
                            selectionColor: "#3399FF"
                            selectedTextColor: "white"
                            objectName: "text"
//                            wrapMode: "WrapAnywhere"
                            textFormat: TextEdit.PlainText

                            clip: true
                            font.pointSize: 18
                            anchors.left: dot.right
                            anchors.leftMargin: 5
                            text: model.edit
                            onActiveFocusChanged: {
                                if (activeFocus) {
                                    if (myClass.hasMultipleSiblings(
                                                nodeTree.model.mapToSource(
                                                    nodeTree.currentIndex))) {
                                        dot.color = "blue"
                                    }
                                    if (!myClass.acceptsCopies(
                                                nodeTree.model.mapToSource(
                                                    nodeTree.currentIndex))) {
                                        dot.color = "green"
                                    }
                                } else {
                                    dot.color = "black"
                                }
                            }


                            onTextChanged: {


                                if (nodeTree.activeFocus) {
                                    console.log("before1 " +contentHeight)

                                   model.edit = text

                                    console.log("after1 " +contentHeight)

                                    console.log(model.edit)

                                }
                                if (nodeTree.activeFocus
                                        && content.activeFocus) {
//                                    nodeTree.forceLayout()
                                    heightChanged()
                                    widthChanged()
                                }
                            }
//                            MouseArea {
//                                acceptedButtons: Qt.NoButton
//                                hoverEnabled: true
//                                cursorShape: Qt.IBeamCursor
//                                propagateComposedEvents: true
//                                onClicked: mouse.accepted = false
//                                onPressAndHold: mouse.accepted = false
//                                onDoubleClicked: mouse.accepted = false
//                                onPositionChanged: mouse.accepted = false
//                                onReleased: mouse.accepted = false
//                                onPressed: mouse.accepted = false
//                                anchors.fill: parent
//                                onEntered: {
//                                    var posInTreeView = mapToItem(nodeTree,
//                                                                  mouseX, mouseY)
//                                    var row = nodeTree.rowAtY(posInTreeView.y,
//                                                              false)
//                                    nodeTree.currentIndex = nodeTree.mapToModel(
//                                                nodeTree.viewIndex(0, row))
//                                    if (!search.focus) {
//                                        nodeTree.itemAtModelIndex(
//                                                    nodeTree.currentIndex).item.forceActiveFocus()
//                                    }
//                                }
//                            }
                        }
                    }
                }

//                ScrollBar.horizontal: ScrollBar {
//                    id: hbar

//                    height: 12
//                    policy: ScrollBar.AlwaysOn
//                    active: true
//                }
//                ScrollBar.vertical: ScrollBar {
//                    id: vbar

//                    width: 12
//                    policy: ScrollBar.AlwaysOn
//                    active: true
//                }
            }
        }
    }
}
