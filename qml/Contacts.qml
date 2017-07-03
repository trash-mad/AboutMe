import QtQuick 2.7
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0

Rectangle{
    id: mainitem
    color: "whitesmoke"

    Text{
        id: titletext
        text: "Контакты"
        font.pixelSize: 18
        font.bold: true
        color: "#2b7eb3"
        width: mainitem.width
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.top: mainitem.top
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Text{
        id: bottomtext
        anchors.top: titletext.bottom
        anchors.left: mainitem.left
        anchors.right: mainitem.right
        anchors.margins: 10
        font.pixelSize: 12
        width: mainitem.width
        wrapMode: Text.WordWrap
        text: "Я разместил мои данные в боковом меню. Пожалуйста, пролистните от левого края вправо"
    }



    Rectangle{
        color: "whitesmoke"
        id: swipeitem
        anchors.centerIn: parent
        width: mainitem.width
        height: ((mainitem.width<mainitem.height)?mainitem.height:mainitem.width)/5+15
        Image{
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: swipetext.top
            height: parent.height-swipetext.height
            width: height

            source: "qrc:/swiperight.png"

            SequentialAnimation on anchors.leftMargin {
                loops: Animation.Infinite

                NumberAnimation {
                    from: -100; to: 100
                    easing.type: Easing.InBack; duration: 3000
                }





                PauseAnimation { duration: 1200 }
            }
        }
        Text{
            id: swipetext
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignBottom
            height: 10
            text: "Откройте боковое меню"
        }



    }



}


