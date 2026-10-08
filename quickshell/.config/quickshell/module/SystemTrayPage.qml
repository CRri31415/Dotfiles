import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Services.SystemTray

import ".."

Item {
    id: root

    implicitWidth: 300
    implicitHeight: trayContentItem.implicitHeight + 20

    Item {
        id: trayContentItem
        visible: true

        anchors.fill: parent
        anchors.margins: 10
        
        implicitHeight: emptyText.visible ? emptyText.implicitHeight : trayRow.implicitHeight
        
        Text {
            id: emptyText
            visible: SystemTray.items?.values?.length === 0
            anchors.centerIn: parent
    
            text: "💥"
            font.pixelSize: 12
            color: Colors.onSurface
        }
    
        RowLayout {
            id: trayRow
            visible: SystemTray.items?.values?.length > 0

            anchors.centerIn: parent
            spacing: 10
    
            Repeater {
                model: SystemTray.items
    
                delegate: Item {
                    id: trayItem
                    required property var modelData
    
                    width: 24
                    height: 24
    
                    Image {
                        anchors.centerIn: parent
                        width: 20
                        height: 20
    
                        source: modelData?.icon || ""
                        fillMode: Image.PreserveAspectFit
                    }

                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: Qt.LeftButton | Qt.RightButton
                        cursorShape: Qt.PointingHandCursor
                        
                        onClicked: (mouse) => {
                            if (mouse.button === Qt.LeftButton) {
                                modelData.activate()
                            } else if (mouse.button === Qt.RightButton) {
                                if (modelData.hasMenu) {
                                    modelData.menu.open(mouse.x, mouse.y)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
