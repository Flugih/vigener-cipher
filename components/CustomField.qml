import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

//import crypto.components

Item {
    id: root

    property alias wrongAnimation: wrongInputAnimation
    property alias field: field

    ParallelAnimation {
        id: wrongInputAnimation

        running: false

        BorderPulse {
            id: fieldPulse

            borderTarget: fieldBackground
        }
    }

    TextField {
        id: field

        anchors.fill: parent
        color: "white"
        selectionColor: "#053ba7"
        placeholderTextColor: "#7d7d7d"
        verticalAlignment: TextInput.AlignVCenter
        //leftPadding: 15

        background: Rectangle {
            id: fieldBackground

            radius: 7
            border.color: "#2f3e4e"
            color: "#0f1621"
        }
    }
}
