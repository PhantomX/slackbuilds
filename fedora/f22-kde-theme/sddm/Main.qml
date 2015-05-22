/***************************************************************************
* Copyright (c) 2013 Martin Bříza <mbriza@redhat.com>
*
* Permission is hereby granted, free of charge, to any person
* obtaining a copy of this software and associated documentation
* files (the "Software"), to deal in the Software without restriction,
* including without limitation the rights to use, copy, modify, merge,
* publish, distribute, sublicense, and/or sell copies of the Software,
* and to permit persons to whom the Software is furnished to do so,
* subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included
* in all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
* OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
* OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
* ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
* OR OTHER DEALINGS IN THE SOFTWARE.
*
***************************************************************************/


import QtQuick 2.0
import SddmComponents 2.0

Rectangle {

    TextConstants { id: textConstants }

    Connections {
        target: sddm

        onLoginSucceeded: {
            errorMessage.color = "green"
            errorMessage.text = textConstants.loginSucceeded
        }
        onLoginFailed: {
            errorMessage.color = "red"
            errorMessage.text = textConstants.loginFailed
        }
    }

    Repeater {
        model: screenModel
        Item {
            Background {
                x: geometry.x; y: geometry.y; width: geometry.width; height:geometry.height
                source: config.background
                fillMode: Image.Stretch
            }
        }
    }

    Rectangle {
        property variant geometry: screenModel.geometry(screenModel.primary)
        x: geometry.x
        y: geometry.y
        width: geometry.width
        height: geometry.height
        color: "transparent"

        Image {
            id: fedoraLogo
            x: parent.width / 2 - width / 2
            y: parent.height / 2 - height / 2
            source: "/usr/share/pixmaps/system-logo-white.png"
        }

        Rectangle {
            x: geometry.x
            y: geometry.y
            width: parent.width
            height: 34

            opacity: 0.4
            color: "black"
        }

        Row {
            x: parent.x + 4
            y: parent.y + 4
            spacing: 4
            width: parent.width - 8
            z: 100

            Row {
                spacing: 4
                width: parent.width/2
                ComboBox {
                    id: session
                    width: 250
                    height: 24
                    font.pixelSize: 14

                    model: sessionModel
                    index: sessionModel.lastIndex

                    KeyNavigation.backtab: password; KeyNavigation.tab: layoutBox
                }

                LayoutBox {
                    id: layoutBox; height: 24
                    font.pixelSize: 14

                    KeyNavigation.backtab: session; KeyNavigation.tab: loginButton
                }
            }

            Row {
                anchors.right: parent.right
                spacing: 4

                Button {
                    id: rebootButton
                    text: textConstants.reboot
                    height: 25
                    width: 100

                    onClicked: sddm.reboot()

                    KeyNavigation.backtab: shutdownButton; KeyNavigation.tab: name
                }

                Button {
                    id: shutdownButton
                    text: textConstants.shutdown
                    height: 25
                    width: 100

                    onClicked: sddm.powerOff()

                    KeyNavigation.backtab: loginButton; KeyNavigation.tab: rebootButton
                }
            }
        }

        Rectangle {
            x: parent.x
            y: parent.y + parent.height/2
            width: parent.width
            height: parent.height/2
            color: "transparent"
            Column {
                width: 260
                anchors.centerIn: parent
                spacing: 18

                Row {
                    width: parent.width
                    Text {
                        width: parent.width
                        color: "white"
                        text: textConstants.welcomeText.arg(sddm.hostName)
                        wrapMode: Text.WordWrap
                        font.pixelSize: 12
                        elide: Text.ElideRight
                        horizontalAlignment: Text.AlignHCenter
                    }
                }

                Row {
                    width: parent.width
                    TextBox {
                        id: name
                        width: parent.width
                        height: 30
                        text: userModel.lastUser
                        font.pixelSize: 14

                        KeyNavigation.backtab: rebootButton; KeyNavigation.tab: password

                        Keys.onPressed: {
                            if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                                sddm.login(name.text, password.text, session.index)
                                event.accepted = true
                            }
                        }
                    }
                }

                Row {
                    width: parent.width
                    PasswordBox {
                        id: password
                        width: parent.width * 0.9
                        height: 30
                        font.pixelSize: 14
                        tooltipBG: "lightgrey"

                        KeyNavigation.backtab: name; KeyNavigation.tab: session

                        Keys.onPressed: {
                            if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                                sddm.login(name.text, password.text, session.index)
                                event.accepted = true
                            }
                        }
                    }

                    Button {
                        width: parent.width * 0.1
                        height: 31
                        id: loginButton
                        text: qsTr(">")

                        onClicked: sddm.login(name.text, password.text, session.index)

                        KeyNavigation.backtab: layoutBox; KeyNavigation.tab: shutdownButton
                    }
                }

                Column {
                    width: parent.width
                    Text {
                        id: errorMessage
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: textConstants.prompt
                        font.pixelSize: 10
                        color: "white"
                    }
                }
            }
        }
    }

    // doesn't do anything :/
    Component.onCompleted: {
        if (name.text === "")
            name.forceActiveFocus()
        else
            password.forceActiveFocus()
        hackTimer.start()
    }

    // can't tell why it doesn't set the focus when component is completed, this hacks around it
    Timer {
        id: hackTimer
        interval: 100
        repeat: false
        onTriggered: {
            if (name.text === "")
                name.forceActiveFocus()
            else
                password.forceActiveFocus()
        }
    }
}
