
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.12
import QtQuick.TreeView 2.15
import TreeModel.com 1.0
//import TreeModel.com1 1.0
import Qt.labs.platform 1.0
import QtQuick.Layouts 1.11
import Qt.labs.qmlmodels 1.0
import Qt.labs.settings 1.0


ApplicationWindow {
    id:you
    property var array:[]
property var arrayOfWindows:[]
    property Settings settings:Settings{

property var temn:[]

    }

visible:false
//property var mainViewArray: [];
Component.onCompleted: {
    console.log("aaaa  "+settings.temn)

    if(settings.temn.length ===0){
        var component = Qt.createComponent("WindowComponent.qml");
                       var window    = component.createObject(you);
          you.array.push(window)
           window.showMaximized();
    }
    else{
   for(var i = 0;i< settings.temn.length;i++){

        var component = Qt.createComponent("WindowComponent.qml");
                       var window    = component.createObject(you);
          you.array.push(window)
           window.showMaximized();
       window.x = settings.temn[i][0];
       window.y = settings.temn[i][1];
       window.width = settings.temn[i][2];
       window.height = settings.temn[i][3];

for(var j = 4; j<settings.temn[i].length;j++){

    var Randomnumber = Math.random().toString(36).substr(2, 5);
    var component1 = Qt.createQmlObject("import TreeModel.com 1.0; Filtering { id: car_" +  Randomnumber + "; }",
                                           window);
    var Randomnumber1 = Math.random().toString(36).substr(2, 5);
    var delegateInstance = Qt.createQmlObject("Delegate { id: car_" +  Randomnumber1 + "; }",
                                           window);


    window.viewArray.push(delegateInstance.createObject(window.tes1,{test:component1}));
console.log("settings.temn[i][j][0]" + settings.temn[i][j][0]);
    console.log("settings.temn[i][j][1]" + settings.temn[i][j][1]);
    console.log("settings.temn[i][j][2]" + settings.temn[i][j][2]);
    console.log("settings.temn[i][j][3]" + settings.temn[i][j][3]);
    console.log("settings.temn[i][j][4]" + settings.temn[i][j][4]);


//    window.viewArray[window.viewArray.length -1].x = settings.temn[i][j][0];
//    window.viewArray[window.viewArray.length -1].y = settings.temn[i][j][1];
//        window.viewArray[window.viewArray.length -1].parent.width = settings.temn[i][j][2]
//        window.viewArray[window.viewArray.length -1].parent.height = settings.temn[i][j][3]
//window.viewArray[window.viewArray.length -1].ser.append (settings.temn[i][j][4])






}

var u = 0
    for(var j = 4; j<settings.temn[i].length;j++,u++){
        window.viewArray[u].parent.x = settings.temn[i][j][0];
        window.viewArray[u].parent.y = settings.temn[i][j][1];
            window.viewArray[u].parent.width = settings.temn[i][j][2]
            window.viewArray[u].parent.height = settings.temn[i][j][3]
    window.viewArray[u].ser.append (settings.temn[i][j][4])
    }


    }
}


}

Component.onDestruction:  {
//    settings.arrayOfWindows.length = 0;
//    for(var i = 0;i<you.array.length;i++){
////        settings.arrayOfWindows.push(you.array[i].settings)

//        settings.arrayOfWindows.push(JSON.stringify(you.array[i]))

//    }
////settings.arrayOfWindows = you.array
//    console.log("aaaa  "+settings.arrayOfWindows)

}
    Shortcut {
    sequence: "Ctrl+K"
    onActivated:  {
        var component = Qt.createComponent("WindowComponent.qml")

                    var window    = component.createObject(you)
        you.array.push(window)

        window.showMaximized()
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




}
