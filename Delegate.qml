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

                    id:yyy1

                            Rectangle {


                                id:newId1
                                visible:true
                                implicitHeight: 50
                                implicitWidth: 1920
                                focus:true
                                property bool hasChildren: TreeView.hasChildren
                                property bool isExpanded: TreeView.isExpanded
                                property int depth: TreeView.depth

                                Component.onCompleted:    {
                //                                           var posInTreeView = waaa.mapFromItem(parent, point.position)
                //                                           var row = waaa.rowAtY(posInTreeView.y, true)
                                       console.log(visible)
                                     console.log("uuuuuu  "+ myProxy.getBool())
//                                    if(myProxy.getBool()){

//                                        newId.visible === true
//                                        console.log("aaaa" + visible)
//                                    }

                                                           if (isExpanded == false)
                                                               waaa.expand(tap1.row) //TODO
                                                       }
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
                                    id: indicator11
                                    x: depth * waaa.styleHints.indent

                                    color: "black"
                                    font: waaa.styleHints.font
                                    text: hasChildren ? (isExpanded ? "▼" : "▶") : ""
                                    anchors.verticalCenter: parent.verticalCenter


                                    TapHandler {
                                        id:tap1
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
                                        id: ball11
                                        x: depth * waaa.styleHints.indent +indicator11.width*1.5
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
                                    x: indicator11.x + Math.max(waaa.styleHints.indent, indicator11.width * 1.5)
                                    text: edit
                                    onEditingFinished: edit = text
                                }
                       }
                }




