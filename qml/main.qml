import QtQuick 2.7
import QtQuick.Controls 2.2

Item{
    id: mainitem
    width: 320
    height: 480


    Drawer {
        id: drawer
        width: Math.min(mainitem.width, mainitem.height) / 3 * 2
        height: mainitem.height

        ListView {
            id: listView

            focus: true
            currentIndex: -1
            anchors.fill: parent

            delegate: ItemDelegate {
                width: parent.width
                Image {
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    width: parent.height
                    source: model.image
                }
                Text{
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.leftMargin: parent.height
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    text: model.title
                }

                highlighted: ListView.isCurrentItem
                onClicked: {
                    Qt.openUrlExternally(model.source)
                    drawer.close()
                }
            }

            model: ListModel {
                ListElement { title: "tripolskypetr@gmail.com"; image:"qrc:/gmail.png"; source: "mailto:tripolskypetr@gmail.com" }
                ListElement { title: "u1963172"; image:"qrc:/youdo.png"; source: "http://youdo.com/u1963172" }
                ListElement { title: "GitHub"; image:"qrc:/githubcat.png"; source: "http://tripolskypetr.github.io/" }
            }

            ScrollIndicator.vertical: ScrollIndicator { }
        }
    }

    /*PageIndicator {
        count: view.count
        currentIndex: view.currentIndex
        rotation: 90
        anchors.top: mainitem.top
        anchors.left: mainitem.left
        anchors.topMargin: mainitem.height/2-height
        z: 100
    }*/


    SwipeView {
        id: view
        currentIndex: 0
        height: mainitem.height
        width: mainitem.width
        orientation: Qt.Vertical

        AboutMe{}
        MyWorks{}
        SettingsPage{}
        Contacts{}


    }

}


