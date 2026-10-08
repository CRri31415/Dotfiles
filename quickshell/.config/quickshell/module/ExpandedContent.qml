import QtQuick
import QtQuick.Layouts
import ".."

Item {
    id: root
    property int currentIndex: 0

    function resetMain(){
        currentIndex = 0
    }

    implicitWidth: {
        switch (currentIndex) {
            case 0: return mainViewPage.implicitWidth
            case 1: return systemTrayPage.implicitWidth
            case 2: return volumePage.implicitWidth
            return 100
        }
    }
    
    implicitHeight: {
        switch (currentIndex) {
            case 0: return mainViewPage.implicitHeight
            case 1: return systemTrayPage.implicitHeight
            case 2: return volumePage.implicitHeight
            return 100
        }
    }

    MainView {
        id: mainViewPage
        anchors.fill: parent
        anchors.margins: 16
        
        onRequestTrayPage: {
            currentIndex = 1
        }

        onRequestVolumePage: {
            currentIndex = 2
        }

        opacity: root.currentIndex === 0 ? 1.0 : 0.0
        visible: opacity > 0
    }

    SystemTrayPage {
        id: systemTrayPage
        anchors.fill: parent

        opacity: root.currentIndex === 1 ? 1.0 : 0.0
        visible: opacity > 0
    }

    VolumePage {
        id: volumePage
        anchors.fill: parent

        opacity: root.currentIndex === 2 ? 1.0 : 0.0
        visible: opacity > 0
    }
}
