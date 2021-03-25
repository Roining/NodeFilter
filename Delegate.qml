import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.12
import QtQuick.TreeView 2.15
import Qt.labs.platform 1.0
import QtQuick.Dialogs 1.1
import QtQuick.Layouts 1.11
import Qt.labs.qmlmodels 1.0

Component {

    Item {

        id: viewInstance

        property alias tree: nodeTree
        property alias ser: search
        property alias test: nodeTree.model

        objectName: Math.random().toString(36).substr(2, 5)

        SplitView.minimumHeight: 200
        SplitView.preferredHeight: parent.height / 2
        SplitView.minimumWidth: 100
        SplitView.preferredWidth: parent.width / 4
        SplitView.maximumWidth: Screen.width

        Keys.onPressed: {
            if ((event.key === Qt.Key_W)
                              && (event.modifiers & Qt.ControlModifier)
                              && (event.modifiers & Qt.ShiftModifier)) {
                         you.arrayOfWindows.length === 0
                         console.log("you.array   " + you.array)

                         var serializationWindowsArray = []
                         for (var i = 0; i < you.array.length; i++) {

                             var windowData = [you.array[i].x, you.array[i].y, you.array[i].width, you.array[i].height]

                             serializationWindowsArray.push(windowData)

                             for (var j = 0; j < you.array[i].viewArray.length; j++) {

                                 var viewData = [you.array[i].viewArray[j].x, you.array[i].viewArray[j].y, you.array[i].viewArray[j].width, you.array[i].viewArray[j].height, you.array[i].viewArray[j].ser.text]
                                 serializationWindowsArray[i].push(viewData)


                             }
                         }

                         for (var i = 0; i < you.array.length; i++) {
                             you.arrayOfWindows.push((serializationWindowsArray[i]))
                         }
                         you.settings.windows = you.arrayOfWindows
                         myClass.save();
                         Qt.quit()
                         return;
                     }
            else if ((event.key === Qt.Key_W)
                                           && (event.modifiers & Qt.ControlModifier)) {
                                    // Delete view Alt D
                                    viewInstance.destroy()
                                    return
                                }

        }

        Component.onDestruction: {
            for (var i = 0; i < parent.parent.root.viewArray.length; i++) {
                if (viewInstance.objectName.toString(
                            ) === parent.parent.root.viewArray[i].objectName.toString(
                            )) {
                    parent.parent.root.viewArray.splice(i, 1)
                    if(parent.parent.root.viewArray.length ===0){
                        parent.parent.root.destroy();
                    }
                    break
                }
            }
        }

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
                clip: true
                objectName: "search"
                placeholderText: "Search here"
                Keys.onEscapePressed: {
                    var posInTreeView = mapToItem(nodeTree, 0, 0)
                    console.log("ttttt " + nodeTree.currentModelIndex)
                    var row = nodeTree.rowAtY(posInTreeView, true)
                    nodeTree.currentModelIndex = nodeTree.viewIndex(0, row)
                    nodeTree.itemAtModelIndex(
                                nodeTree.currentModelIndex).item.forceActiveFocus()
                }

                onTextChanged: {

                    nodeTree.model.setQuery(text)
                }
            }

            TreeView {
                id: nodeTree

                property var rowHeight: 40
                property var indexNow: nodeTree.currentModelIndex.row
                property var parentIndex: nodeTree.model.parent(
                                              nodeTree.currentModelIndex)
                contentHeight: 3000
                contentWidth: 2000
                clip: true
                reuseItems: true
                rowHeightProvider: function (row) {

                    var array = []
                    for (var child in nodeTree.contentItem.children) {

                        if (nodeTree.contentItem.children[i].conHeight) {

                            array.push(nodeTree.contentItem.children[child].conHeight)
                        }
                    }

                    return nodeTree.contentItem.children[row].conHeight
                }

                width: viewInstance.width
                height: viewInstance.height - search.height
                styleHints.overlay: "green"
                styleHints.indent: 25
                styleHints.columnPadding: 30
                Component.onCompleted: {
                    console.log("fgfghfgh" + viewInstance.parent)
                    var posInTreeView = mapToItem(nodeTree, 0, 0)
                    console.log("ttttt " + nodeTree.currentModelIndex)
                    var row = nodeTree.rowAtY(posInTreeView, true)
                    nodeTree.currentModelIndex = nodeTree.viewIndex(0, 0)
                    //        nodeTree.forceActiveFocus()
                    nodeTree.itemAtModelIndex(
                                nodeTree.currentModelIndex).forceActiveFocus()
                }

Keys.onDigit2Pressed: {
    for (var i = 0; i < viewInstance.parent.parent.root.viewArray.length; i++) {
        if (viewInstance.objectName.toString(
                    ) === viewInstance.parent.parent.root.viewArray[i].objectName.toString(
                    )) {
            console.log("brrrrr  " + viewInstance.parent.parent.root.viewArray[i].x)

//            parent.parent.root.viewArray.splice(i, 1)
            break
        }
    }
console.log("windowInstance.width: " + viewInstance.width)
    console.log("windowInstance.x: " + viewInstance.x)
    console.log("windowInstance.y: " + viewInstance.y)


}
                Keys.onPressed: {
                    if ((event.key === Qt.Key_P)
                            && (event.modifiers & Qt.ControlModifier)
                            && (event.modifiers & Qt.ShiftModifier)) {
                        myClass.acceptsCopies(nodeTree.model.mapToSource(
                                                  nodeTree.currentModelIndex), true)
                        return
                    }
                   else  if ((event.key === Qt.Key_W)
                             && (event.modifiers & Qt.ControlModifier)
                             && (event.modifiers & Qt.ShiftModifier)) {
                        you.arrayOfWindows.length === 0
                        console.log("you.array   " + you.array)

                        var serializationWindowsArray = []
                        for (var i = 0; i < you.array.length; i++) {

                            var windowData = [you.array[i].x, you.array[i].y, you.array[i].width, you.array[i].height]

                            serializationWindowsArray.push(windowData)

                            for (var j = 0; j < you.array[i].viewArray.length; j++) {

                                var viewData = [you.array[i].viewArray[j].x, you.array[i].viewArray[j].y, you.array[i].viewArray[j].width, you.array[i].viewArray[j].height, you.array[i].viewArray[j].ser.text]
                                serializationWindowsArray[i].push(viewData)


                            }
                        }

                        for (var i = 0; i < you.array.length; i++) {
                            you.arrayOfWindows.push((serializationWindowsArray[i]))
                        }
                        you.settings.windows = you.arrayOfWindows
                        myClass.save();
                        Qt.quit()
                        return;
                    }
                    else if ((event.key === Qt.Key_G)
                               && (event.modifiers & Qt.ControlModifier)
                               && (event.modifiers & Qt.ShiftModifier)) {
                        allIndeces(nodeTree.currentModelIndex)

                        return
                    } else if ((event.key === Qt.Key_Q)
                               && (event.modifiers & Qt.ControlModifier)
                               && (event.modifiers & Qt.ShiftModifier)) {

                        for (var i = 0; i < viewInstance.parent.parent.root.viewArray.length; i++) {
                            console.log("contentHeight : " + viewInstance.parent.parent.root.viewArray
                                        + " windowInstance.objectName " + viewInstance.parent.parent.root.viewArray[i]
                                        + "  objectName " + viewInstance.parent.parent.root.viewArray[i - 1])

                            if (viewInstance.parent.parent.root.viewArray[i].objectName.toString(
                                        ) == viewInstance.objectName.toString()) {
                                console.log("contentHeight : " + viewInstance.parent.parent.root.viewArray
                                            + " windowInstance.objectName "
                                            + viewInstance.parent.parent.root.viewArray[i] + "  objectName "
                                            + viewInstance.parent.parent.root.viewArray[i - 1])
                                if ((i - 1) > -1) {
                                    viewInstance.parent.parent.root.viewArray[i - 1].tree.itemAtModelIndex(
                                                viewInstance.parent.parent.root.viewArray[i - 1].tree.currentModelIndex).item.forceActiveFocus()
                                }
                                break
                            }
                        }
                        return
                    }

                    else if ((event.key === Qt.Key_E)
                               && (event.modifiers & Qt.ControlModifier)
                               && (event.modifiers & Qt.ShiftModifier)) {
                        //acceptsCopies true Ctrl Shift P
                        for (var i = 0; i < viewInstance.parent.parent.root.viewArray.length; i++) {
                            if (viewInstance.parent.parent.root.viewArray[i].objectName.toString(
                                        ) === viewInstance.objectName.toString()) {
                                console.log("contentHeight : " + viewInstance.parent.parent.root.viewArray
                                            + " windowInstance.objectName "
                                            + viewInstance.parent.parent.root.viewArray[i] + "  objectName "
                                            + viewInstance.parent.parent.root.viewArray[i + 1])
                                if ((i + 1) < viewInstance.parent.parent.root.viewArray.length) {
                                    viewInstance.parent.parent.root.viewArray[i + 1].tree.itemAtModelIndex(
                                                viewInstance.parent.parent.root.viewArray[i + 1].tree.currentModelIndex).item.forceActiveFocus()
                                }
                                break
                            }
                        }


                        return
                    } //     else if((event.key === Qt.Key_L)&&(event.modifiers &Qt.ControlModifier) &&(event.modifiers &Qt.ShiftModifier)){ //insert new node without transclusion

                    //      myClass.insertRows(0,1,nodeTree.mo,false)//TODO
                    //        return;
                    //    }
                    else if ((event.key === Qt.Key_N)
                             && (event.modifiers & Qt.ControlModifier)
                             && (event.modifiers & Qt.ShiftModifier)) {

                        //insert new node as a child Ctrl Shift N
                        myClass.insertRows(0, 1, nodeTree.model.mapToSource(
                                               nodeTree.currentModelIndex)) //TODO
                        nodeTree.expandModelIndex(nodeTree.currentModelIndex)

                        return
                    } else if ((event.key === Qt.Key_M)
                               && (event.modifiers & Qt.ControlModifier)
                               && (event.modifiers & Qt.ShiftModifier)) {
                        //copy node as child Ctrl Shift M
                        event.accepted = true

                        myClass.copyRows(0, 1, nodeTree.model.mapToSource(
                                             nodeTree.currentModelIndex),
                                         myClass.getLastIndex()) //TODO
                        nodeTree.expandModelIndex(nodeTree.currentModelIndex)
                        return
                    } else if ((event.key === Qt.Key_P)
                               && (event.modifiers & Qt.ControlModifier)) {
                        //acceptsCopies false Ctrl P
                        myClass.acceptsCopies(nodeTree.model.mapToSource(
                                                  nodeTree.currentModelIndex),
                                              false)
                        return
                    }
                    else if ((event.key === Qt.Key_S)
                             && (event.modifiers & Qt.ControlModifier)) {
                        //serialize/save Ctrl S
                        myClass.save()
                        return
                    } else if ((event.key === Qt.Key_5)
                               && (event.modifiers & Qt.ControlModifier)) {
                        event.accepted = true
                        //serialize/save Ctrl S
                        if (nodeTree.currentModelIndex.hasChildren) {
                            nodeTree.currentModelIndex = nodeTree.model.index(
                                        0, 0, nodeTree.currentModelIndex)
                        }
                        else {
                            nodeTree.currentModelIndex = nodeTree.model.index(
                                        nodeTree.currentModelIndex.row + 1, 0,
                                        nodeTree.currentModelIndex.parent)
                        }
                        return
                    }
                    else if ((event.key === Qt.Key_W)
                                                   && (event.modifiers & Qt.ControlModifier)) {
                                            // Delete view Alt D
                                            viewInstance.destroy()
                                            return
                                        }
                    else if ((event.key === Qt.Key_8)
                                                  && (event.modifiers & Qt.ControlModifier)) {
                    you.settings.windows = [];
                        you.array.length = []
                        console.log("you.settings.windows  "+ you.settings.windows)
                        console.log(" you.array  "+  you.array)

                        Qt.quit();
                    }
                    else if ((event.key === Qt.Key_D)
                               && (event.modifiers & Qt.ControlModifier)) {

                        //remove node Ctrl D
                        deleteDialog.open()
                        return
                    }
                    else if ((event.key === Qt.Key_U)
                             && (event.modifiers & Qt.ControlModifier)) {

                        //remove node Ctrl D
                        hbar.decrease()
                        return
                    } else if ((event.key === Qt.Key_O)
                               && (event.modifiers & Qt.ControlModifier)) {

                        //remove node Ctrl D
                        search.forceActiveFocus()
                        search.clear()
                        search.append(">:" + myClass.getId(
                                          nodeTree.model.mapToSource(
                                              nodeTree.currentModelIndex)))
                        return
                    } else if ((event.key === Qt.Key_Q)
                               && (event.modifiers & Qt.ControlModifier)) {

                        //copy a copied node Ctrl A
                        myClass.saveIndex(nodeTree.model.mapToSource(
                                              nodeTree.currentModelIndex)) //TODO
                        return
                    } else if ((event.key === Qt.Key_E)
                               && (event.modifiers & Qt.ControlModifier)) {
                        //copy Id to clipboard Ctrl E
                        myClass.getIdToClipboard(nodeTree.model.mapToSource(
                                                     nodeTree.currentModelIndex))
                        return
                    } else if ((event.key === Qt.Key_F)
                               && (event.modifiers & Qt.ControlModifier)) {
                        //Ctrl F
                        search.forceActiveFocus()
                        search.selectAll()
                        return
                    }  else if ((event.key === Qt.Key_N)
                               && (event.modifiers & Qt.ControlModifier)) {
                        //Ctrl N insert node
                        var position = myClass.position(
                                    nodeTree.model.mapToSource(
                                        nodeTree.currentModelIndex))
                        myClass.insertRows(
                                    position + 1, 1,
                                    nodeTree.model.mapToSource(
                                        nodeTree.currentModelIndex).parent) //TODO

                        return
                    } else if ((event.key === Qt.Key_J)
                               && (event.modifiers & Qt.ControlModifier)) {
                        //Ctrl N insert node
                        var test1 = nodeTree.currentModelIndex.parent
                        console.log(test1)
                        nodeTree.currentModelIndex
                        return
                    } else if ((event.key === Qt.Key_M)
                               && (event.modifiers & Qt.ControlModifier)) {
                        //Ctrl M copy node
                        event.accepted = true
                        var position = myClass.position(
                                    nodeTree.model.mapToSource(
                                        nodeTree.currentModelIndex))

                        myClass.copyRows(position + 1, 1,
                                         nodeTree.model.mapToSource(
                                             nodeTree.currentModelIndex).parent,
                                         myClass.getLastIndex()) //TODO
                    } else if ((event.key === Qt.Key_G)
                               && (event.modifiers & Qt.ControlModifier)) {
                        nodeTree.toggleModelIndexExpanded(nodeTree.currentModelIndex)

                    }
                }

                onCurrentModelIndexChanged: {

                    if ((!search.focus)) {
                        if (nodeTree.activeFocus) {
                            itemAtModelIndex(
                                        nodeTree.currentModelIndex).item.forceActiveFocus()
                            //                                            console.log("77777777777 " + nodeTree.currentModelIndex.row)
                        }
                    }
                }
                function allIndeces(ind) {

                    nodeTree.expandModelIndex(ind)
                    for (var i = 0; i < nodeTree.model.rowCount(ind); i++) {
                        nodeTree.expandModelIndex(ind)
                        var index = nodeTree.model.index(i, 0, ind)

                        nodeTree.expandModelIndex(index)
                        if (nodeTree.model.rowCount(index) !== 0) {

                            allIndeces(index)
                        }
                    }

                    return
                }
                MessageDialog {
                    id: deleteDialog
                    title: "Warning"
                    text: "Are you sure you want to delete the selected node? Children nodes will also be deleted"
                    onAccepted: {
                        var position = myClass.position(
                                    nodeTree.model.mapToSource(
                                        nodeTree.currentModelIndex))

                        myClass.removeRows(
                                    position, 1, nodeTree.model.mapToSource(
                                        nodeTree.currentModelIndex).parent) //TODO
                        console.log("Selected node was deleted")
                    }

                    standardButtons: StandardButton.Ok | StandardButton.Close
                }
                MouseArea {
                    id: pos

                    anchors.fill: parent
                    hoverEnabled: true
                    onWheel: {

                        if (wheel.modifiers & Qt.ShiftModifier) {
                            if (wheel.angleDelta.y > 0) {
                                hbar.increase()
                            } else if (wheel.angleDelta.y < 0) {
                                hbar.decrease()
                            }
                        } else if (wheel.angleDelta.y < 0) {

                            vbar.increase()
                        } else if (wheel.angleDelta.y > 0) {
                            vbar.decrease()
                        }
                    }

                }
                delegate: Component {

                    id: delegateComponent

                    Rectangle {
                        id: delegateRoot

                        property alias item: content
                        property alias dot: dot
                        property bool hasFocus
                        property bool hasChildren: TreeView.hasChildren
                        property bool isExpanded: TreeView.isExpanded
                        property int depth: TreeView.depth
                        property var conHeight: content.height

                        visible: true
                        implicitHeight: conHeight
                        implicitWidth: viewInstance.parent.width
                        focus: true
                          clip: true

                        MouseArea {
                            anchors.fill: parent
                            acceptedButtons: Qt.NoButton
                            hoverEnabled: true
                            cursorShape: Qt.IBeamCursor
                            propagateComposedEvents: true
                            onClicked: mouse.accepted = false
                            onPressAndHold: mouse.accepted = false
                            onDoubleClicked: mouse.accepted = false
                            onPositionChanged: mouse.accepted = false
                            onReleased: mouse.accepted = false
                            onPressed: mouse.accepted = false
                            onEntered: {
                                if (!search.focus) {
                                    var posInTreeView = mapToItem(nodeTree, 0, 0)

                                    var row = nodeTree.rowAtY(posInTreeView.y,
                                                          false)

                                    nodeTree.currentModelIndex = nodeTree.mapToModel(
                                                nodeTree.viewIndex(0, row))
                                    nodeTree.itemAtModelIndex(
                                                nodeTree.currentModelIndex).item.forceActiveFocus()
                                }
                            }
                        }
                        Text {
                            id: expandIndicator

                            x: depth * nodeTree.styleHints.indent + 5
                            color: "black"
                            font: nodeTree.styleHints.font
                            text: hasChildren ? (isExpanded ? "▼" : "▶") : ""
                            anchors.verticalCenter: parent.verticalCenter

                            TapHandler {
                                id: tap
                                onTapped: {
                                    var posInTreeView = nodeTree.mapFromItem(
                                                parent, point.position)
                                    var row = nodeTree.rowAtY(posInTreeView.y, true)
                                    nodeTree.currentIndex = nodeTree.viewIndex(0, row)
                                    console.log("function row  " + row + "  index row  "
                                                + nodeTree.currentIndex.row)

                                    if (tapCount == 1)
                                        nodeTree.toggleExpanded(row)
                                }
                            }
                        }
                        Text {
                            id: dot

                            x: depth * nodeTree.styleHints.indent + 15
                            color: "black"
                            // anchors.left :  indicator1
                            anchors.leftMargin: 100
                            font: nodeTree.styleHints.font
                            text: "⬤"
                            anchors.verticalCenter: parent.verticalCenter

                            TapHandler {
                                id: dotTapHandler
                                onTapped: {
                                    var posInTreeView = nodeTree.mapFromItem(
                                                parent, point.position)
                                    var row = nodeTree.rowAtY(posInTreeView.y, true)
                                    nodeTree.currentIndex = nodeTree.viewIndex(0, row)
                                    console.log("function row  " + row + "  index row  "
                                                + nodeTree.currentIndex.row)

                                    if (tapCount == 1)

                                        search.forceActiveFocus()
                                    search.selectAll()
                                    search.append(
                                                ">:" + myClass.getId(
                                                    nodeTree.model.mapToSource(
                                                        nodeTree.currentModelIndex)))
                                }
                            }
                        }

                        TextArea {
                            id: content

                            width: delegateRoot.width
                            selectByMouse: true
                            selectionColor: "#3399FF"
                            selectedTextColor: "white"
                            objectName: "text"
                            wrapMode: "WrapAnywhere"
                            textFormat: TextEdit.MarkdownText
                            clip: true
                            font.pointSize: 18
                            anchors.left: dot.right
                            anchors.leftMargin: 5
                            text: edit
                            onActiveFocusChanged: {
                            if(activeFocus){
                                if(myClass.hasMultipleSiblings(nodeTree.model.mapToSource(nodeTree.currentModelIndex))){
                                                            dot.color = "blue"

                                                            }
                                if(!myClass.acceptsCopies(nodeTree.model.mapToSource(nodeTree.currentModelIndex))){
                                dot.color = "green"}

                            }
                            else{
                            dot.color = "black"
                            }
                            }

//                            Component.onCompleted: {
//                            if(nodeTree.focus){

//                            if(myClass.hasMultipleSiblings(nodeTree.currentModelIndex)){
//                            dot.color = "blue"

//                            }

//                            }
//                            }
                            onTextChanged: {
                                if (nodeTree.activeFocus) {
                                    edit = text
                                }
                                if (nodeTree.activeFocus && content.activeFocus) {
                                    console.log("height  " + content.height)
                                    nodeTree.forceLayout()
                                    heightChanged()
                                    widthChanged()
                                }
                            }
                            MouseArea {
                                acceptedButtons: Qt.NoButton
                                hoverEnabled: true
                                cursorShape: Qt.IBeamCursor
                                propagateComposedEvents: true
                                onClicked: mouse.accepted = false
                                onPressAndHold: mouse.accepted = false
                                onDoubleClicked: mouse.accepted = false
                                onPositionChanged: mouse.accepted = false
                                onReleased: mouse.accepted = false
                                onPressed: mouse.accepted = false
                                anchors.fill: parent
                                onEntered: {
                                    var posInTreeView = mapToItem(viewInstance, 0, 0)
                                    var row = nodeTree.rowAtY(posInTreeView.y,
                                                          false)
                                    nodeTree.currentModelIndex = nodeTree.mapToModel(
                                                nodeTree.viewIndex(0, row))
                                    if (!search.focus) {
                                        nodeTree.itemAtModelIndex(
                                                    nodeTree.currentModelIndex).item.forceActiveFocus()
                                    }
                                }
                            }
                        }
                    }
                }

                ScrollBar.horizontal: ScrollBar {
                    id: hbar

                    height: 12
                    policy: ScrollBar.AlwaysOn
                    active: true
                }
                ScrollBar.vertical: ScrollBar {
                    id: vbar

                    width: 12
                    policy: ScrollBar.AlwaysOn
                    active: true
                }
            }
        }
    }
}
