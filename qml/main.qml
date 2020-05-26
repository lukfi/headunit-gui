import QtQuick 2.5
import QtQuick.Window 2.2
import Qt.labs.settings 1.0
import QtQuick.Window 2.2
import "ClimateControl"
import "Radio"
Window {

    id: window
    visible: true
    title: qsTr("viktorgino's HeadUnit")
    visibility: Window.Windowed
    width: 1200
    height: 800

    FontLoader{id:ralewayRegular; source:"qrc:/qml/fonts/Raleway-Regular.ttf"}

    Rectangle {
        id: rectangle1
        color: "#000000"
        anchors.fill: parent
    }
    DashView{
        id: dashview
        anchors.fill: parent
        onCurrentVisible: {
            GUIEvents.guiEventRaised("CURRENT", index);
        }
    }
    Shortcut {
        sequence: "F11"
        onActivated: {
            if(window.visibility == Window.Windowed)
                window.visibility = Window.FullScreen
//            else if(window.visibility == Window.FullScreen)
//                window.visibility = Window.Maximized
            else
                window.visibility = Window.Windowed
        }
    }
    Item {
        anchors.fill: parent
        focus: true
        Keys.onPressed: {
            event.accepted = true;
            GUIEvents.guiEventRaised("KEY", event.key);
//            if (event.key == Qt.Key_Left) {
//                console.log("move left");
//            }
        }
    }
}
