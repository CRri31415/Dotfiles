import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import Quickshell.Services.UPower

import ".."

RowLayout {
    ColumnLayout {
        id: root
        spacing: 6
        
        Layout.fillWidth: true
        Layout.fillHeight: true

        signal requestVolumePage()
        signal requestMediaPage()
        signal requestTrayPage()
        signal requestHardwarePage()

        Process {
            id: logoutProcess
            command: ["wlogout", "-b", "2", "-L", "400", "-R", "400"]
        }

        Process {
            id: nmtuiProcess
            command: ["kitty", "-e", "nmtui"]
        }

        Process {
            id: idleInhibitProcess
            command: ["systemd-inhibit", "--what=idle", "--who=Quickshell", "--why=UserToggled", "sleep", "365d"]
        }

        property bool idleInhibited: false

        onIdleInhibitedChanged: {
            idleInhibitProcess.running = root.idleInhibited
        }
        
        Process {
            id: volProcess
            command: ["wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@"]
            running: true
            stdout: SplitParser {
                onRead: data => {
                    let isMuted = data.includes("[MUTED]")
                    let match = data.match(/Volume:\s+([0-9.]+)/)
            
                    if (match) {
                        let vol = Math.round(parseFloat(match[1]) * 100)
                        volText.text = isMuted ? "MUTED" : vol + "%"
                        volIcon.text = isMuted ? "󰝟" : (vol > 60 ? "󰕾" : (vol > 0 ? "󰖀" : "󰕿"))
                    }
                }
            }
        }

        property string connectedSsid: ""
        property int signalStrength: 0
        
        Process {
            id: wifiProcess
            command: ["/home/user/dotfiles/custom-script/get-wifi.sh"]
            running: true
        
            stdout: SplitParser {
                onRead: data => {
                    let line = data.trim()
                    if (!line) return
        
                    let parts = line.split(":")
                    let ssid = parts[0] || "Disconnected"
                    let signal = parseInt(parts[1]) || 0
        
                    if (ssid !== "Disconnected" && ssid !== "") {
                        root.connectedSsid = ssid
                        root.signalStrength = signal
                        wifiText.text = ssid
        
                        if (signal > 75) wifiIcon.text = "󰤨 "
                        else if (signal > 50) wifiIcon.text = "󰤥 "
                        else if (signal > 25) wifiIcon.text = "󰤢 "
                        else wifiIcon.text = "󰤟 "
                    } else {
                        root.connectedSsid = ""
                        wifiText.text = "Disconnected"
                        wifiIcon.text = "󰤮 "
                    }
                }
            }
        }

        Timer {
            interval: 3000
            running: true
            repeat: true
            triggeredOnStart: true
            onTriggered: wifiProcess.running = true
        }

        Process {
            id: tempProcess
            command: ["/home/user/dotfiles/custom-script/max-temp.sh"]

            stdout: SplitParser {
                onRead: data => {
                    let trimmed = data.trim()
                    if (!trimmed) return

                    let tempStr = trimmed

                    tempText.text = tempStr

                    let val = parseFloat(tempStr)
                    if (!isNaN(val)) {
                        if (val >= 80) {
                            tempIcon.text = "󰸁 "
                            tempIcon.color = Colors.errorColor
                        } else if (val >= 60) {
                            tempIcon.text = "󱃂 "
                            tempIcon.color = Colors.onSurface
                        } else {
                            tempIcon.text = " "
                            tempIcon.color = Colors.onSurface
                        }
                    }
                }
            }
        }

        Timer {
            interval: 1000
            running: true
            repeat: true
            triggeredOnStart: true
            onTriggered: tempProcess.running = true
        }

        
        RowLayout {
            spacing: 6

            Rectangle {
                implicitWidth: 24
                implicitHeight: 24
                radius: 12
                color: Colors.onSurface

                MouseArea {
                    id: logoutButton
                    anchors.fill: parent
                    onClicked: logoutProcess.running = true
                }
            }

            Rectangle {
                implicitWidth: 24
                implicitHeight: 24
                radius: 12
                color: root.idleInhibited ? Colors.primaryColor : Colors.onSurface

                Text {
                    anchors.centerIn: parent
                    text: root.idleInhibited ? "💡" : "🛏️"            
                    font.pixelSize: 16
                    font.family: "JuliaMono Nerd Font"
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        root.idleInhibited = !root.idleInhibited
                    }
                }
            }
        }

        Item {Layout.fillHeight: true}
        
        SystemClock {
            id: clock
            precision: SystemClock.Seconds
        }
        
        Text {
            color: Colors.onSurface
            font.pixelSize: 26
            font.bold: true
            font.family: "JuliaMono Nerd Font"
            text: Qt.formatDateTime(clock.date, "hh:mm:ss")
        }
    
        Text {
            color: Colors.onSurface
            font.pixelSize: 13
            font.family: "JuliaMono Nerd Font"
    
            text: Qt.formatDateTime(clock.date, "yyyy-MM-dd ddd")
            
        }
    }

    Item {Layout.fillWidth: true}
    
    ColumnLayout {
        Layout.fillWidth: true
        Layout.fillHeight: true
        spacing: 10

        Layout.alignment: Qt.AlignRight
        
        Rectangle {
            implicitWidth: wifiRow.implicitWidth
            implicitHeight: 20
            color: "transparent"

            Layout.preferredWidth: implicitWidth
            Layout.alignment: Qt.AlignRight
            
            RowLayout {
                id: wifiRow
                Text {
                    id: wifiIcon
                    font.pixelSize: 15
                    font.family: "JuliaMono Nerd Font"
                    color: Colors.onSurface
                }
                Text {
                    id: wifiText
                    font.pixelSize: 15
                    font.family: "JuliaMono Nerd Font"
                    color: Colors.onSurface
                 }
            }

            MouseArea {
                id: wifiMouse
                anchors.fill: parent
                onClicked: nmtuiProcess.running = true
            }
        }

        Rectangle {
            implicitWidth: volRow.implicitWidth
            implicitHeight: 24
            color: "transparent"

            Layout.preferredWidth: implicitWidth
            Layout.alignment: Qt.AlignRight
                      
            RowLayout {
                id: volRow
                Text {
                    id: volIcon
                    text: "x"
                    font.pixelSize: 18
                    font.family: "JuliaMono Nerd Font"
                    color: Colors.onSurface
                }
                Text {
                    id: volText
                    text: " - %"
                    font.pixelSize: 18
                    font.family: "JuliaMono Nerd Font"
                    color: Colors.onSurface
                    Layout.preferredWidth: 44
                    horizontalAlignment: Text.AlignRight
                }
            }

            MouseArea {
                id: volMouse
                anchors.fill: parent
                onClicked: root.requestVolumePage()
            }
        }

        Rectangle {
            implicitWidth: hardwareRow.implicitWidth
            implicitHeight: 24
            color: "transparent"

            Layout.preferredWidth: implicitWidth
            Layout.alignment: Qt.AlignRight

            RowLayout {
                id: hardwareRow
                Text {
                    id: tempIcon
                    font.pixelSize: 18
                    font.family: "JuliaMono Nerd Font"
                    color: Colors.onSurface
                }
                Text {
                    id: tempText
                    font.pixelSize: 18
                    font.family: "JuliaMono Nerd Font"
                    color: Colors.onSurface
                }
                Text {
                    text: {
                        let batteryDevice = UPower.displayDevice
                        if (batteryDevice.state === UPowerDeviceState.Charging) return " "
                        return "🔋"
                    }
                    font.pixelSize: 18
                    font.family: "JetBrainsMono Nerd Font"
                    color: Colors.onSurface
                    Layout.preferredWidth: 18
                }
                Text {
                    text: Math.round((UPower.displayDevice.percentage ?? 100) * 100) + "%"
                    font.pixelSize: 18
                    font.family: "JuliaMono Nerd Font"
                    color: Colors.onSurface
                    Layout.preferredWidth: 44
                    horizontalAlignment: Text.AlignRight
                }
            }

            MouseArea {
                id: hardwareMouse
                anchors.fill: parent
                onClicked: root.requestHardwarePage()
            }
        }
        
        RowLayout {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignRight
            spacing: 8

            Rectangle {
                implicitWidth: 20
                implicitHeight: 20
                radius: 10
                color: Colors.onSurface
                Layout.alignment: Qt.AlignRight

                MouseArea {
                    id: mediaMouse
                    anchors.fill: parent
                    onClicked: root.requestMediaPage()
                }
            }

            Rectangle {
                implicitWidth: 20
                implicitHeight: 20
                radius: 10
                color: Colors.onSurface
                Layout.alignment: Qt.AlignRight

                MouseArea {
                    id: trayMouse
                    anchors.fill: parent
                    onClicked: root.requestTrayPage()
                }
            }
        }
    }
}
