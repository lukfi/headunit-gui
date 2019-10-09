import QtQuick 2.6
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.0
import QtGraphicalEffects 1.0

import HUDTheme 1.0

Item {
    id: root
    clip: true

    Rectangle {
        color: HUDStyle.Colors.formBackground
        anchors.fill: parent
    }

    StackView {
        id:settingsPageStack
        anchors.topMargin: 16
        anchors.top: header.bottom
        anchors.right: parent.right
        anchors.rightMargin: 16
        anchors.left: parent.left
        anchors.leftMargin: 16
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 16
        initialItem: settingsPageList
    }

    Component {
        id:stackComponent
        Loader{
            id:stackLoader
            Connections {
                ignoreUnknownSignals: true
                target: stackLoader.item
                onPush: {
                    settingsPageStack.push(stackComponent,{source:qml,properties:properties})
                }
                onPop: {
                    settingsPageStack.pop()
                }
            }
        }
    }

    Component{
        id:settingsPageList
        SettingsPageItemList{
            settings: HUDSettings
            model: HUDSettingsMenu
            onPush: {
                if(qml === "SettingsPageItemList"){
                    properties.settings = settings[properties.name]
                    settingsPageStack.push(settingsPageList, properties)
                } else {
                    settingsPageStack.push(stackComponent)
                    settingsPageStack.currentItem.setSource(qml, properties)
                    //settingsPageStack.push(qml, properties)
                }
            }
            onPop: {
                settingsPageStack.pop()
            }
        }
    }

    Item {
        id: header
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        height:parent.height * 0.15
        anchors.leftMargin: 0

        Item {
            id: item2
            anchors.bottomMargin: -20
            anchors.fill: parent

            RectangularGlow {
                id: effect
                anchors.fill: rect
                glowRadius: 20
                spread: -0.1
                color: "#000000"
                cornerRadius: 0
            }

            Rectangle {
                id: rect
                color: HUDStyle.Colors.formBox
                clip: true
                anchors.bottomMargin: 20
                anchors.fill: parent
            }


        }

        Image {
            id: image
            width: height
            height: parent.height/2
            anchors.leftMargin: width/2
            anchors.verticalCenter: parent.verticalCenter
            fillMode: Image.PreserveAspectFit
            anchors.left: parent.left
            source: settingsPageStack.depth===1?"qrc:/qml/icons/android-settings.png":"qrc:/qml/icons/svg/android-arrow-back.svg"
            mipmap:true

            ColorOverlay {
                color: "#ffffff"
                anchors.fill: parent
                enabled: true
                source: parent
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if(typeof settingsPageStack.currentItem.back === "function"){
                        settingsPageStack.currentItem.back()
                    } else if (settingsPageStack.currentItem.item && (typeof settingsPageStack.currentItem.item.back === "function")){
                        settingsPageStack.currentItem.item.back()
                    } else if (settingsPageStack.depth > 0) {
                        settingsPageStack.pop()
                    }
                }
            }
        }

        ThemeHeaderText {
            id: text1
            text: qsTr("Settings")
            anchors.leftMargin: image.width/2
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: image.right
            anchors.right: parent.right
            anchors.rightMargin: 15
        }

    }
}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
