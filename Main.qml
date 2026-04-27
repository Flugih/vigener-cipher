import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Basic

import VigenereCrypt
import crypto.components

Window {
    width: 455
    height: 515
    maximumWidth: 505
    maximumHeight: 565
    minimumWidth: 455
    minimumHeight: 515

    visible: true
    title: qsTr("cr")
    color: "#18222d"

    VigenereCrypt {
        id: vigenereCrypt
    }

    Connections {
        target: vigenereCrypt

        function onCryptFinished(result) {
            resultTextArea.text = result;
        }
    }


    ColumnLayout {
        id: body

        anchors.fill: parent
        anchors.margins: 25
        spacing: 20

        ColumnLayout {
            id: textInputColumn

            Layout.preferredHeight: 1

            Text {
                Layout.fillWidth: true
                color: "#3390ec"
                text: qsTr("Текст для обработки")
                font.pointSize: 11
            }

            CustomField {
                id: textInputField

                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }

        ColumnLayout {
            id: keyInputColumn

            Layout.preferredHeight: 1

            Text {
                Layout.fillWidth: true
                color: "#3390ec"
                text: qsTr("Ключ шифрования")
                font.pointSize: 11
            }

            CustomField {
                id: keyInputField

                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }

        RowLayout {
            id: methodPick

            spacing: 15

            Rectangle {
                id: encryptButton

                Layout.fillWidth: true
                Layout.preferredHeight: 42

                color: encryptMouseArea.containsMouse ? "#2b74ba" : "#3390ec"
                radius: 7

                Behavior on color {
                    ColorAnimation {
                        duration: 100
                    }
                }

                Text {
                    id: encryptText

                    font.pointSize: 11
                    font.bold: true
                    color: "white"
                    anchors.centerIn: parent

                    text: qsTr("Зашифровать")
                }

                MouseArea {
                    id: encryptMouseArea

                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor

                    onClicked: {
                        let text = textInputField.field.text;
                        let key = keyInputField.field.text;

                        if (text !== "" && key !== "")
                        {
                            vigenereCrypt.encrypt(text, key);
                        }
                        else
                        {
                            if (text === "")
                            {
                                textInputField.wrongAnimation.start();
                            }

                            if (key === "")
                            {
                                keyInputField.wrongAnimation.start();
                            }
                        }
                    }
                }
            }

            Rectangle {
                id: decryptButton

                Layout.fillWidth: true
                Layout.preferredHeight: 42

                border.color: "#2f3e4e"
                color: decryptMouseArea.containsMouse ? "#1a2a3c" : "#18222d"
                radius: 7

                Behavior on color {
                    ColorAnimation {
                        duration: 100
                    }
                }

                Text {
                    id: decryptText

                    font.pointSize: 11
                    font.bold: true
                    color: "#2a90ec"
                    anchors.centerIn: parent

                    text: qsTr("Расшифровать")
                }

                MouseArea {
                    id: decryptMouseArea

                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor

                    onClicked: {
                        let text = textInputField.field.text;
                        let key = keyInputField.field.text;

                        if (text !== "" && key !== "")
                        {
                            vigenereCrypt.decrypt(text, key);
                        }
                        else
                        {
                            if (text === "")
                            {
                                textInputField.wrongAnimation.start();
                            }

                            if (key === "")
                            {
                                keyInputField.wrongAnimation.start();
                            }
                        }
                    }
                }
            }
        }

        ColumnLayout {
            id: result

            Layout.preferredHeight: 4

            Text {
                Layout.fillWidth: true
                color: "#3390ec"
                text: qsTr("Результат")
                font.pointSize: 11
            }

            ScrollView {
                id: resultScroll

                Layout.fillWidth: true
                Layout.fillHeight: true
                //ScrollBar.vertical.policy: ScrollBar.AsNeeded
                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                ScrollBar.vertical: ScrollBar {
                    id: verticalScroll

                    height: parent.height
                    width: 6
                    hoverEnabled: true
                    anchors.right: parent.right
                    policy: ScrollBar.AsNeeded

                    contentItem: Rectangle {
                        radius: 3
                        color: verticalScroll.pressed ? "#3390ec" : verticalScroll.hovered ? "#2b74ba" : "#2f3e4e"
                    }

                    background: Rectangle {
                        color: "#2f3e4e"
                    }
                }

                clip: true

                Component.onCompleted: {
                    contentItem.boundsBehavior = Flickable.StopAtBounds
                }

                TextArea {
                    id: resultTextArea

                    width: resultScroll.width
                    text: ""
                    readOnly: true
                    wrapMode: TextEdit.WrapAnywhere
                    selectionColor: "#053ba7"
                    color: "white"

                    background: Rectangle {
                        radius: 7
                        border.color: "#2f3e4e"
                        color: "#0f1621"
                    }
                }
            }
        }
    }
}
