import QtQuick 2.7
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0

Rectangle{
    id: mainitem
    color: "whitesmoke"


    Rectangle{
        id: headerbar
        width: mainitem.width
        height: mainitem.height/3
        color: "#2b7eb3"
            Image{
                height: 75
                width: 75
                anchors.centerIn: parent
                source: "qrc:/me.png"
            }

            Label{
                text: "Трипольский Пётр Петрович"
                font.pixelSize: 18
                font.bold: true
                color: "white"
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 7
                anchors.horizontalCenter: parent.horizontalCenter
            }

    }

    DropShadow {
            anchors.fill: headerbar
            horizontalOffset: 3
            verticalOffset: 3
            radius: 8.0
            samples: 17
            color: "#80000000"
            source: headerbar
    }



    MouseArea{
        id: secondtext
        anchors.left: mainitem.left
        anchors.right: mainitem.right
        anchors.bottom: mainitem.bottom
        anchors.top: headerbar.bottom
        anchors.topMargin: 10
        height: 50
        width: mainitem.width


        Rectangle{
            color: "white"
            anchors.centerIn: parent
            width: mainitem.width-50
            height: 75

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
                text: "Свайпните для перехода по слайдам"
            }






        }




    }


}


