import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Services.SystemTray

import ".."

ColumnLayout {

    Text {
        visible: SystemTray.items.length === 0
        Layout.alignment: Qt.AlignCenter
        Layout.fillHeight: true

        text: "💥"
        font.pixelSize: 12
    }

    Flow {
        visible: SystemTray.items.length > 0
        Layout.fillWidth: true
        Layout.fillHeight: true
        spacing: 10
        flow: Flow.LeftToRight

        Repeater {
            model: SystemTray.items

            delegate: Item {
                id: trayItem
                required property SystemTrayItem modelData

                implicitWidth: 24
                implicitHeight: 24

                Image {
                    anchors.centerIn: parent
                    
                }
            }
        }
    }
}
