import QtQuick
import QtQuick.Layouts
import Quickshell
import ".."

ColumnLayout {
    id: root
    spacing: 12
  
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
