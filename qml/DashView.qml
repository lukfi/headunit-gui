import QtQuick 2.5
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.4
//import "ClimateControl"
import HUDTheme 1.0

Item {
    id: dashLayout

    signal currentVisible(string index)

    LinearGradient {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#36464e"
            }

            GradientStop {
                position: 1
                color: "#172027"
            }
        }
        end: Qt.point(200, 300)
        start: Qt.point(0, 0)
    }

    BackgroundImage{
        anchors.fill: parent
    }

    Repeater{
        id: contents
        model:menuItems
        Loader {
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.right: rightMenu.left
            anchors.rightMargin: 0
            visible: false
            source: menuItems[index].source
            asynchronous: false
        }
    }

    RightMenu {
        property int lastItemIndex: -1

        id: rightMenu
        width: height/5
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        onItemChanged:{
            if (lastItemIndex != index)
            {
                lastItemIndex = index
                //console.log("OnItemChanged", index)
                if(contents.count > 0){
                    for(var i=0; i<contents.count;i++){
                        contents.itemAt(i).visible = false
                    }
                    //console.log("Current visible index", index, menuItems[index].pluginname)
                    currentVisible(menuItems[index].pluginname)
                    contents.itemAt(index).visible = true
                }
            }
        }
    }

    transitions: Transition {
        NumberAnimation { properties: "y,opacity"; duration: 250}
    }

    Connections {
        target: GUIEvents
        ignoreUnknownSignals: true
        onNotificationReceived:{
            notificationsItem.addNotification(notification)
        }
    }

    Notifications {
        id: notificationsItem
        anchors.fill: parent
    }

    Repeater{
        id:overlays
        model:HUDOverlays
        Loader {
            anchors.fill: parent
            source: HUDOverlays[index]
        }
    }
}
