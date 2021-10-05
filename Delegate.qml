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

        Component.onDestruction: {

            for (var i = 0; i < parent.parent.root.viewArray.length; i++) {




                if (viewInstance.objectName.toString(
                            ) === parent.parent.root.viewArray[i].objectName.toString(
                            )) {

                    parent.parent.root.viewArray.splice(i, 1)
                    if (parent.parent.root.viewArray.length === 0) {
                        parent.parent.root.destroy()
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
                    var posInTreeView = mapToItem(nodeTree, 0, 0)
                    var row = nodeTree.rowAtY(posInTreeView, true)
                    nodeTree.currentModelIndex = nodeTree.viewIndex(0, 0)
                    nodeTree.itemAtModelIndex(
                                nodeTree.currentModelIndex).forceActiveFocus()
                }


                Keys.onPressed: {
                    if ((event.key === Qt.Key_P)
                            && (event.modifiers & Qt.ControlModifier)
                            && (event.modifiers & Qt.ShiftModifier)) {
                        sharedModel.acceptsCopies(nodeTree.model.mapToSource(
                                                  nodeTree.currentModelIndex),
                                              true)
                        return
                    }
                    else if ((event.key === Qt.Key_L)
                            && (event.modifiers & Qt.ControlModifier)
                            && (event.modifiers & Qt.ShiftModifier)) {
                        event.accepted = true

                        sharedModel.loadHierarchy(nodeTree.model.mapToSource(
                                                  nodeTree.currentModelIndex));

                        return
                    }
                    else if ((event.key === Qt.Key_W)
                               && (event.modifiers & Qt.ControlModifier)
                               && (event.modifiers & Qt.ShiftModifier)) {
                        root.arrayOfWindows.length === 0
root.settings.windows.length ===0
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
//                        sharedModel.save()
                        Qt.quit()
                        return
                    } else if ((event.key === Qt.Key_G)
                               && (event.modifiers & Qt.ControlModifier)
                               && (event.modifiers & Qt.ShiftModifier)) {
                        allIndeces(nodeTree.currentModelIndex)

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
                                                viewInstance.parent.parent.root.viewArray[i - 1].tree.currentModelIndex).item.forceActiveFocus()
                                }
                                break
                            }
                        }
                        return
                    } else if ((event.key === Qt.Key_E)
                               && (event.modifiers & Qt.ControlModifier)
                               && (event.modifiers & Qt.ShiftModifier)) {
                        for (var i = 0; i < viewInstance.parent.parent.root.viewArray.length; i++) {
                            if (viewInstance.parent.parent.root.viewArray[i].objectName.toString(
                                        ) === viewInstance.objectName.toString(
                                        )) {

                                if ((i + 1) < viewInstance.parent.parent.root.viewArray.length) {
                                    viewInstance.parent.parent.root.viewArray[i + 1].tree.itemAtModelIndex(
                                                viewInstance.parent.parent.root.viewArray[i + 1].tree.currentModelIndex).item.forceActiveFocus()
                                }
                                break
                            }
                        }

                        return
                    } else if ((event.key === Qt.Key_N)
                               && (event.modifiers & Qt.ControlModifier)
                               && (event.modifiers & Qt.ShiftModifier)) {

                        sharedModel.insertRows(
                                    0, 1, nodeTree.model.mapToSource(
                                        nodeTree.currentModelIndex)) //TODO
                        nodeTree.expandModelIndex(nodeTree.currentModelIndex)

                        return
                    } else if ((event.key === Qt.Key_M)
                               && (event.modifiers & Qt.ControlModifier)
                               && (event.modifiers & Qt.ShiftModifier)) {
                        event.accepted = true

                        sharedModel.copyRows(0, 1, nodeTree.model.mapToSource(
                                             nodeTree.currentModelIndex),
                                         sharedModel.getLastIndex()) //TODO
                        nodeTree.expandModelIndex(nodeTree.currentModelIndex)
                        return
                    } else if ((event.key === Qt.Key_P)
                               && (event.modifiers & Qt.ControlModifier)) {
                        sharedModel.acceptsCopies(nodeTree.model.mapToSource(
                                                  nodeTree.currentModelIndex),
                                              false)
                        return
                    } else if ((event.key === Qt.Key_H)
                               && (event.modifiers & Qt.ControlModifier) && (event.modifiers & Qt.ShiftModifier)) {
                        event.accepted = true

                        sharedModel.copyRows(0, 1, nodeTree.model.mapToSource(
                                             nodeTree.currentModelIndex),
                                         sharedModel.getLastIndex(),true) //TODO
                        nodeTree.expandModelIndex(nodeTree.currentModelIndex)
                        return
                    }
                    else if ((event.key === Qt.Key_S)
                                                   && (event.modifiers & Qt.ControlModifier)) {
                                            sharedModel.save()
                                            return
                                        }
//                    else if ((event.key === Qt.Key_5)
//                               && (event.modifiers & Qt.ControlModifier)) {
//                        event.accepted = true
//                        //serialize/save Ctrl S
//                        if (nodeTree.currentModelIndex.hasChildren) {
//                            nodeTree.currentModelIndex = nodeTree.model.index(
//                                        0, 0, nodeTree.currentModelIndex)
//                        } else {
//                            nodeTree.currentModelIndex = nodeTree.model.index(
//                                        nodeTree.currentModelIndex.row + 1, 0,
//                                        nodeTree.currentModelIndex.parent)
//                        }
//                        return
//                    }
                    else if ((event.key === Qt.Key_W)
                               && (event.modifiers & Qt.ControlModifier)) {

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
                        deleteDialog.open()
                        return
                    } else if ((event.key === Qt.Key_U)
                               && (event.modifiers & Qt.ControlModifier)) {


                        hbar.decrease()
                        return
                    } else if ((event.key === Qt.Key_O)
                               && (event.modifiers & Qt.ControlModifier)) {


                        search.forceActiveFocus()
                        search.clear()
                        search.append(">:" + sharedModel.getId(
                                          nodeTree.model.mapToSource(
                                              nodeTree.currentModelIndex)))
                        return
                    } else if ((event.key === Qt.Key_Q)
                               && (event.modifiers & Qt.ControlModifier)) {

                        sharedModel.saveIndex(
                                    nodeTree.model.mapToSource(
                                        nodeTree.currentModelIndex)) //TODO
                        return
                    } else if ((event.key === Qt.Key_E)
                               && (event.modifiers & Qt.ControlModifier)) {
                        sharedModel.getIdToClipboard(
                                    nodeTree.model.mapToSource(
                                        nodeTree.currentModelIndex))
                        return
                    } else if ((event.key === Qt.Key_F)
                               && (event.modifiers & Qt.ControlModifier)) {
                        search.forceActiveFocus()
                        search.selectAll()
                        return
                    } else if ((event.key === Qt.Key_N)
                               && (event.modifiers & Qt.ControlModifier)) {
                        var position = sharedModel.position(
                                    nodeTree.model.mapToSource(
                                        nodeTree.currentModelIndex))
                        sharedModel.insertRows(
                                    position + 1, 1, nodeTree.model.mapToSource(
                                        nodeTree.currentModelIndex).parent) //TODO

                        return
                    } else if ((event.key === Qt.Key_J)
                               && (event.modifiers & Qt.ControlModifier)) {
                        var test1 = nodeTree.currentModelIndex.parent
                        nodeTree.currentModelIndex
                        return
                    } else if ((event.key === Qt.Key_M)
                               && (event.modifiers & Qt.ControlModifier)) {
                        event.accepted = true
                        var position = sharedModel.position(
                                    nodeTree.model.mapToSource(
                                        nodeTree.currentModelIndex))

                        sharedModel.copyRows(
                                    position + 1, 1, nodeTree.model.mapToSource(
                                        nodeTree.currentModelIndex).parent,
                                    sharedModel.getLastIndex()) //TODO
                    } else if ((event.key === Qt.Key_G)
                               && (event.modifiers & Qt.ControlModifier)) {
                        nodeTree.toggleModelIndexExpanded(
                                    nodeTree.currentModelIndex)
                    }
                }

                onCurrentModelIndexChanged: {

                    if ((!search.focus)) {
                        if (nodeTree.activeFocus) {
                            itemAtModelIndex(
                                        nodeTree.currentModelIndex).item.forceActiveFocus()
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
                        var position = sharedModel.position(
                                    nodeTree.model.mapToSource(
                                        nodeTree.currentModelIndex))

                        sharedModel.removeRows(
                                    position, 1, nodeTree.model.mapToSource(
                                        nodeTree.currentModelIndex).parent) //TODO
                    }

                    standardButtons: StandardButton.Ok | StandardButton.Close
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
                Connections{
                target:sharedModel
                function onRecursionSignal(){
                copyDialog.open();
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
                                    var posInTreeView = mapToItem(nodeTree, mouseX,
                                                                  mouseY)

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
                                    var row = nodeTree.rowAtY(posInTreeView.y,
                                                              true)
                                    nodeTree.currentIndex = nodeTree.viewIndex(
                                                0, row)

                                    if (tapCount == 1)
                                        nodeTree.toggleExpanded(row)
                                }
                            }
                        }
                        Text {
                            id: dot

                            x: depth * nodeTree.styleHints.indent + 15
                            color: "black"
                            anchors.leftMargin: 100
                            font: nodeTree.styleHints.font
                            text: "⬤"
                            anchors.verticalCenter: parent.verticalCenter

                            TapHandler {
                                id: dotTapHandler
                                onTapped: {
                                    search.forceActiveFocus()
                                    search.clear()
                                    search.append(">:" + sharedModel.getId(
                                                      nodeTree.model.mapToSource(
                                                          nodeTree.currentModelIndex)))
                                    return

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
                            textFormat: TextEdit.PlainText
                            clip: true
                            font.pointSize: 18
                            anchors.left: dot.right
                            anchors.leftMargin: 5
                            text: edit
                            onActiveFocusChanged: {
                                if (activeFocus) {
                                    if (sharedModel.hasMultipleSiblings(
                                                nodeTree.model.mapToSource(
                                                    nodeTree.currentModelIndex))) {
                                        dot.color = "blue"
                                    }
                                    if (!sharedModel.acceptsCopies(
                                                nodeTree.model.mapToSource(
                                                    nodeTree.currentModelIndex))) {
                                        dot.color = "green"
                                    }
                                } else {
                                    dot.color = "black"
                                }
                            }

                            onTextChanged: {
                                if (nodeTree.activeFocus) {
                                    edit = text
                                }
                                if (nodeTree.activeFocus
                                        && content.activeFocus) {
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
                                    var posInTreeView = mapToItem(nodeTree,
                                                                  mouseX, mouseY)
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
