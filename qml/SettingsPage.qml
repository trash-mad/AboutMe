import QtQuick 2.9
import QtQml.Models 2.2
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.1
import Qt.labs.settings 1.0

Rectangle{
    id: mainitem
    color: "whitesmoke"

    property string json: '[{"name":"C++"},{"name":"Java"},{"name":"C#"},{"name":"Delphi"},{"name":"JS"}]'


    property bool isDone: false

    Settings {
            property alias json: mainitem.json
    }

    MessageDialog {
        id: messageDialog
        title: "Изменения сохранены..."
        text: "Расположение сохранено и сохранится при перезапуске."
    }


    Rectangle{
        id: titletext
        z: 100
        color: "white"
        width: mainitem.width
        height: 80
        anchors.top: mainitem.top
        anchors.topMargin: 0
        anchors.bottomMargin: 25
        anchors.horizontalCenter: parent.horizontalCenter
        Text {
            anchors.fill: parent
            text: "Я умею работать с моделями данных"
            color: "#2b7eb3"
            font.pixelSize: 18
            font.bold: true
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

GridView {
    id: grid
    anchors.top: titletext.bottom
    anchors.left: mainitem.left
    anchors.right: mainitem.right
    anchors.bottom: footertext.top
    anchors.margins: 40
    width: 320
    cellWidth: mainitem.width; cellHeight: (mainitem.height-titletext.height-footertext.height-40)/itemModel.count
    interactive: false


    displaced: Transition {
        NumberAnimation { properties: "x,y"; easing.type: Easing.OutQuad }
    }

//! [0]
    model: DelegateModel {
//! [0]
        id: visualModel
        model: ListModel {
            id: itemModel


        }
//! [1]
        delegate: MouseArea {
            id: delegategrid

            property int visualIndex: DelegateModel.itemsIndex

            width: grid.width; height: (mainitem.height-titletext.height-footertext.height-40)/itemModel.count
            drag.target: icon

            Rectangle {
                id: icon
                width: grid.width; height: (mainitem.height-titletext.height-footertext.height-40)/itemModel.count
                anchors {
                    horizontalCenter: parent.horizontalCenter;
                    verticalCenter: parent.verticalCenter
                }


                    Label{
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        horizontalAlignment: Label.AlignLeft
                        verticalAlignment: Label.AlignVCenter
                        font.pixelSize: 22
                        text: model.name
                    }

                    Image{
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        height: 80
                        width: height
                        source: "qrc:/swipeupdown.png"
                        opacity: (delegategrid.visualIndex==0&&!mainitem.isDone)?1:0;


                        SequentialAnimation on anchors.topMargin {
                            loops: Animation.Infinite

                            NumberAnimation {
                                from: 5; to: 10
                                easing.type: Easing.OutExpo; duration: 300
                            }


                            NumberAnimation {
                                from: 10; to: 5
                                easing.type: Easing.OutExpo; duration: 300
                            }


                            PauseAnimation { duration: 1500 }
                        }

                    }




                color: (delegategrid.visualIndex%2==1)?"white":"whitesmoke";

                Drag.active: delegategrid.drag.active
                Drag.source: delegategrid
                Drag.hotSpot.x: 36
                Drag.hotSpot.y: 36

                states: [
                    State {
                        when: icon.Drag.active
                        ParentChange {
                            target: icon
                            parent: grid
                        }

                        AnchorChanges {
                            target: icon;
                            anchors.horizontalCenter: undefined;
                            anchors.verticalCenter: undefined
                        }
                    }
                ]
            }

            DropArea {
                anchors { fill: parent; margins: 15 }

                onEntered: {
                    visualModel.items.move(drag.source.visualIndex, delegategrid.visualIndex)
                }
                onExited: {
                    itemModel.move(model.index,drag.source.visualIndex,1)

                    var i=0;
                    var text="[";
                    for(i=0;i<grid.model.count;i++){
                    text+='{"name":"'+itemModel.get(i).name+'"},'
                    }
                    text = text.substring(0, text.length - 1);
                    text+="]"
                    mainitem.json=text


                    if(!mainitem.isDone) showani.start();
                    mainitem.isDone=true
                }
            }
        }
//! [1]
    }

}


Text{
    id: footertext
    anchors.left: mainitem.left
    anchors.right: mainitem.right
    anchors.bottom: mainitem.bottom
    width: mainitem.width
    wrapMode: Text.WordWrap
    text: "*Изменения вступают в силу моментально и остаются после перезапуска программы."
}

Rectangle{
    color: "white"
    id: scrolldown
    anchors.left: mainitem.left
    anchors.right: mainitem.right
    anchors.bottom: mainitem.bottom
    height: footertext.height
    opacity: 0
    z: 100

    Image{
        id: updownimage
        source: "qrc:/swipe.png"
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.leftMargin: 5
        height: parent.height-10
        width: height
        SequentialAnimation on anchors.topMargin {
            loops: Animation.Infinite

            NumberAnimation {
                from: 5; to: 0
                easing.type: Easing.OutExpo; duration: 300
            }

            NumberAnimation {
                from: 0; to: 5
                easing.type: Easing.OutExpo; duration: 300
            }





            PauseAnimation { duration: 1500 }
        }
    }

    Text{
        anchors.left: updownimage.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        height: parent.height
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.WordWrap
        font.pixelSize: 17
        text: "Перейдите на следующий слайд"
    }

    NumberAnimation on opacity {
        running: false
        id: showani
        from: 0; to: 1
        easing.type: Easing.OutExpo; duration: 750
    }

}




Component.onCompleted: {
    itemModel.append(JSON.parse(mainitem.json))
}
}
