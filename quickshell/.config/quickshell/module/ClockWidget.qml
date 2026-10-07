import QtQuick
import Quickshell
import ".."

Rectangle {
    implicitWidth: 144
    implicitHeight: 30
    radius: 12
    color: Colors.onSecondary
    
    Text {
        id: clockText
        anchors.centerIn: parent
        color: Colors.onSurface
        font.pixelSize: 13
        font.bold: true
        font.family: "JuliaMono Nerd Font"
    
        SystemClock {
            id: clock
            precision: SystemClock.Seconds
        }
    
        text: Qt.formatDateTime(clock.date, "hh:mm:ss")
    }
}
