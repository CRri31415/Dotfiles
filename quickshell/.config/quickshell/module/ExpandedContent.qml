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
            return 100
        }
    }
    
    implicitHeight: {
        switch (currentIndex) {
            case 0: return mainViewPage.implicitHeight
            case 1: return systemTrayPage.implicitHeight
            return 100
        }
    }

    MainView {
        id:mainViewPage
        anchors.fill: parent
        anchors.margins: 16
        onRequestTrayPage: {
            currentIndex = 1
        }

        opacity: root.currentIndex === 0 ? 1.0 : 0.0
        visible: opacity > 0
        onImplicitWidthChanged: console.log("[MainView] implicitWidth:", implicitWidth)
        onImplicitHeightChanged: console.log("[MainView] implicitHeight:", implicitHeight)
    }

    SystemTrayPage {
        id: systemTrayPage
        anchors.fill: parent

        opacity: root.currentIndex === 1 ? 1.0 : 0.0
        visible: opacity > 0

        onImplicitWidthChanged: console.log("[SystemTrayPage] implicitWidth:", implicitWidth)
        onImplicitHeightChanged: console.log("[SystemTrayPage] implicitHeight:", implicitHeight)
    }
}
