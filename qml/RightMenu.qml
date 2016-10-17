import QtQuick 2.0
import QtQuick.Layouts 1.0

Item {
    id: rightMenu
    signal itemChanged(var source);
    property var menuItems: [
        {
            source :"qrc:/qml/ClimateControl/CCLayout.qml",
            image:"icons/thermometer.png",
            text:"A/C",
            color:"#d32f2f"
        },
        {
            source :"Item",
            image:"icons/gear-a.png",
            text:"Settings",
            color:"#fbc02d"
        },
        {
            source :"qrc:/qml/Radio/RadioLayout.qml",
            image:"icons/radio-waves.png",
            text:"Radio",
            color:"#512da8"
        },
        {
            source :"Item",
            image:"icons/social-android.png",
            text:"Android Auto",
            color:"#388e3c"
        },
        {
            source :"Item",
            image:"icons/music-note.png",
            text:"Music",
            color:"#0288d1"
        }

    ]
    function menuItemClicked (y,index){
        active_button_bg.y = y-1;
        rightMenu.itemChanged(menuItems[index].source);
    }

    Rectangle {
        color: "#212121"
        anchors.fill: parent
    }

    Rectangle {
        id: active_button_bg
        height: (parent.height/menuItems.length)+5
        color: "#80ffffff"
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        Layout.columnSpan: 0
        Layout.rowSpan: 0
        border.width: 0

        Behavior on y {

            NumberAnimation {
                //This specifies how long the animation takes
                duration: 600
                //This selects an easing curve to interpolate with, the default is Easing.Linear
                easing.type: Easing.OutBounce
            }
        }

    }

    ColumnLayout {
        anchors.rightMargin: 5
        anchors.leftMargin: 5
        anchors.bottomMargin: 5
        anchors.topMargin: 5
        spacing: 5
        anchors.fill: parent

        Repeater{
            model:menuItems.length
            Rectangle {
                color:menuItems[index].color
                Layout.fillHeight: true
                Layout.columnSpan: 1
                Layout.fillWidth: true

                Image {
                    id: ac_image
                    y: 33
                    width: 30
                    height: 30
                    anchors.verticalCenter: parent.verticalCenter

                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    fillMode: Image.PreserveAspectFit
                    source: menuItems[index].image
                }

                Text {
                    id: text1
                    color: "#ffffff"
                    text: menuItems[index].text
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    anchors.left: ac_image.right
                    anchors.leftMargin: 0
                    wrapMode: Text.WordWrap
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 16
                }

                MouseArea {
                    id: mouseArea1
                    anchors.fill: parent
                    onClicked: menuItemClicked(parent.y,index)
                }
            }
        }
    }
}