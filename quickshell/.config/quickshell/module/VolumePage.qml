import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire

import ".."

Item {
    id: root

    implicitWidth: 300
    implicitHeight: 50

    property int volumeLevel: 0
    property bool isMuted: false
    
    Process {
        id: volProcess
        command: ["wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@"]
        running: true
        stdout: SplitParser {
            onRead: data => {
                root.isMuted = data.includes("[MUTED]")
                let match = data.match(/Volume:\s+([0-9.]+)/)

                if (match) {
                    root.volumeLevel = Math.round(parseFloat(match[1]) * 100)
                }
            }
        }
    }

    Process {
        id: setVolProcess
        property int targetVolume: 0
        command: ["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", targetVolume + "%"]
    }

    Process {
        id: toggleMuteProcess
        command: ["wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@", "toggle"]
    }

    Item {
        id: contentItem
        anchors.fill: parent
        anchors.margins: 8

        RowLayout {
            anchors.centerIn: parent
            width: parent.width
            spacing: 12

            Text {
                id: volIcon
                text: root.isMuted ? "󰝟" : (root.volumeLevel > 60 ? "󰕾" : (root.volumeLevel > 0 ? "󰖀" : "󰕿"))
                font.pixelSize: 18
                font.family: "JuliaMono Nerd Font"
                color: Colors.secondaryColor
            }

            Slider {
                id: volSlider
                Layout.fillWidth: true
                from: 0
                to: 100
                stepSize: 1
                value: root.volumeLevel

                onMoved: {
                    setVolProcess.targetVolume = Math.round(value)
                    setVolProcess.running = true
                    volProcess.running = true
                }

                background: Rectangle {
                    x: volSlider.leftPadding
                    y: volSlider.topPadding + volSlider.availableHeight / 2 - height / 2
                    implicitWidth: 200
                    implicitHeight: 30
                    width: volSlider.availableWidth
                    height: implicitHeight
                    radius: 8
                    color: Colors.surfaceColor

                    Rectangle {
                        width: volSlider.visualPosition * parent.width
                        height: parent.height
                        color: Colors.onSurface
                        radius: 8
                    }
                }

                handle: Item {
                    width: 0
                    height: 0
                }
            }

            Text {
                text: root.isMuted ? "MUTED" : root.volumeLevel + "%"
                font.pixelSize: 13
                font.family: "JuliaMono Nerd Font"
                color: Colors.secondaryColor
                Layout.preferredWidth: 42
                horizontalAlignment: Text.AlignRight
            }
        }
    }
}
