import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.2
import QtQuick.Scene3D 2.0
import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0
import Qt3D.Extras 2.0
import QtCharts 2.0
import QtQuick.Controls 1.4 as QC21

Rectangle{
    id: mainitem
    color: "whitesmoke"

    Text{
        id: titletext
        text: "Что я умею"
        font.pixelSize: 18
        font.bold: true
        color: "#2b7eb3"
        width: mainitem.width
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.top: mainitem.top
        anchors.topMargin: 10
        anchors.bottomMargin: 25
        anchors.horizontalCenter: parent.horizontalCenter
    }


    SwipeView {
        id: view
        currentIndex: 0
        anchors.top: titletext.bottom
        anchors.bottom: indicator.top
        anchors.horizontalCenter: mainitem.horizontalCenter
        //height: mainitem.height-titletext.height-indicator.height
        width: mainitem.width
        orientation: Qt.Horizontal

        ColumnLayout{

            Label{
                text:"Я умею создавать динамические диаграммы"
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
                wrapMode: Label.Wrap
                Layout.fillWidth: true
            }

            ChartView {
                id: chart
                title: "Соотношение ОС на рынке"
                Layout.fillHeight: true
                Layout.fillWidth: true
                legend.alignment: Qt.AlignBottom
                antialiasing: true

                PieSeries {
                    id: pieSeries
                    PieSlice { label: "Windows"; value: 91.56; color: "dodgerblue" }
                    PieSlice { label: "Mac"; value: 7.14; color: "#C30000"}
                    PieSlice { label: "Linux"; value: 1.3; color: "green" }
                }
            }


        RowLayout{
            Layout.maximumHeight: 100
            Layout.fillWidth: true

            Rectangle{
                Layout.fillWidth: true
            }

            Image{
                Layout.maximumHeight: 100
                Layout.maximumWidth: 100
                source: "qrc:/swipeleft.png"
                width: 100
                height: 100
                SequentialAnimation on Layout.rightMargin {
                    loops: Animation.Infinite

                    NumberAnimation {
                        from: 0; to: 10
                        easing.type: Easing.OutExpo; duration: 300
                    }


                    NumberAnimation {
                        from: 10; to: 0
                        easing.type: Easing.OutExpo; duration: 300
                    }


                    PauseAnimation { duration: 1500 }
                }
            }
            }
        }

        ColumnLayout{

            Label{
                text:"Я умею работать с 3D графикой"
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
                wrapMode: Label.Wrap
                Layout.fillWidth: true
            }


            Scene3D {
                id: scene3d
                Layout.fillHeight: true
                Layout.fillWidth: true
                focus: true
                aspects: ["input", "logic"]
                cameraAspectRatioMode: Scene3D.AutomaticAspectRatio


                Entity {
                    id: sceneRoot


                    /*FirstPersonCameraController{
                        camera: camera
                    }*/

                    Camera {
                        id: camera
                        projectionType: CameraLens.PerspectiveProjection
                        fieldOfView: 45
                        nearPlane : 0.1
                        farPlane : 1000.0
                        position: Qt.vector3d(0.7413501739501953,1.0257740020751953,0.8059651255607605)
                        upVector: Qt.vector3d( -0.01093771867454052, 0.9997140169143677, -0.021258771419525146 )
                        viewCenter: Qt.vector3d(1.1482172012329102, 1.0412817001342773, 1.3258962631225586 )
                        onViewCenterChanged: {
                            console.log("viewCenterX="+viewCenter.x)
                            console.log("viewCenterY="+viewCenter.y)
                            console.log("viewCenterZ="+viewCenter.z)
                            console.log("upVectorX="+upVector.x)
                            console.log("upVectorY="+upVector.y)
                            console.log("upVectorZ="+upVector.z)
                            console.log("positionX="+position.x)
                            console.log("positionY="+position.y)
                            console.log("positionZ="+position.z)
                            console.log("----------------")
                        }
                    }


                    components: [
                        RenderSettings {
                            activeFrameGraph: ForwardRenderer {
                                camera: camera
                                clearColor: "transparent"
                            }
                        },
                        InputSettings { }
                    ]

                    PhongMaterial {
                        id: material
                    }

                    Entity {
                        components: [
                            PointLight {
                                color: "#0C2535"
                                intensity: 10
                                constantAttenuation: 1.0
                                linearAttenuation: 0.0
                                quadraticAttenuation: 0.0025


                            },
                            Transform {
                                translation: Qt.vector3d(0.7194540500640869, 1.058485507965088, 1.5325205326080322)
                            }
                        ]
                    }




                    Entity {
                        components: [
                            PointLight {
                                color: "#0C2535"
                                intensity: 1
                                constantAttenuation: 1.0
                                linearAttenuation: 0.0
                                quadraticAttenuation: 0.0025


                            },
                            Transform {
                                translation: Qt.vector3d(0.8774194121360779, 0.9958263039588928, 1.0293548107147217)
                            }
                        ]
                    }




                    RenderableEntity{
                            id: tripolskymesh
                            source: "qrc:/tripolsky.obj"
                            position: Qt.vector3d(1,1,1)
                            scale:  0.001
                            rotationAxis: Qt.vector3d(1, 0, 0)
                            rotationAngle: 90

                            material: DiffuseMapMaterial {
                                specular: Qt.rgba( 0.2, 0.2, 0.2, 1.0 )
                                shininess: 2.0
                            }
                        }

                }
            }

            Slider {
                Layout.fillWidth: true
                id: slider


                onValueChanged: {
                    tripolskymesh.rotationAngle=value*360+90

                }
            }
            Rectangle{
            color: "whitesmoke"
            Layout.minimumWidth: mainitem.width
            Layout.minimumHeight: 60
            Button{
                anchors.centerIn: parent
                text: "Запустить анимацию"
                onClicked: {
                    slider.value=0.0
                    anitimer.start()
                }
            }
            }

            Timer{
                id: anitimer
                running: false
                interval: 25
                onTriggered: {
                    if(slider.value<1){
                        slider.value+=0.01
                        anitimer.restart()
                    }
                }
            }


        }


        Rectangle{
            color: "whitesmoke"


            Rectangle{
            color: "whitesmoke"
            anchors.centerIn: parent
            width: mainitem.width/2
            height: width

            Image{
                anchors.top: parent.top
                anchors.topMargin: 10
                anchors.left: parent.left
                height: parent.height-10
                width: parent.width-10
                source: "qrc:/swipe.png"
                SequentialAnimation on anchors.topMargin {
                    loops: Animation.Infinite

                    NumberAnimation {
                        from: 10; to: 0
                        easing.type: Easing.OutExpo; duration: 300
                    }

                    NumberAnimation {
                        from: 0; to: 10
                        easing.type: Easing.OutExpo; duration: 300
                    }





                    PauseAnimation { duration: 1500 }
                }
            }
            }
            }






    }

    PageIndicator {
        id: indicator
        count: view.count
        currentIndex: view.currentIndex
        anchors.bottom: mainitem.bottom
        anchors.horizontalCenter: mainitem.horizontalCenter
    }



}


