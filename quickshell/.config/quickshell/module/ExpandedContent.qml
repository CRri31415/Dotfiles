import QtQuick
import QtQuick.Layouts
import ".."

Item{
    id: root

    function resetMain(){
        stackLayout.currentIndex = 0
    }

    implicitWidth: 400
    implicitHeight: 150
    
    StackLayout {
        id: stackLayout
        anchors.fill: parent
        anchors.margins: 16
        currentIndex: 0

        MainView{
        }
    }
}
