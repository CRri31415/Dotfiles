import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "./module"

PanelWindow{
    id: root
    anchors{
        top: true
        left: true
        right: true
    }
    implicitHeight: isExpanded ? 300 : 40
    color: "transparent"
    
    WlrLayershell.layer: WlrLayer.Top
    exclusionMode: ExclusionMode.Ignore

    property bool isExpanded: false

    TapHandler{
        enabled: root.isExpanded
        gesturePolicy: TapHandler.DragThreshold
        onTapped: {
            root.isExpanded = false
            expandedContent.resetMain()
        }
    }

    Rectangle{
        id: islandBar
        anchors.top: parent.top
        anchors.topMargin: root.isExpanded ? 0 : 4
        anchors.horizontalCenter: parent.horizontalCenter

        color: root.isExpanded ? Colors.surfaceColor : Colors.onSecondary
        border.width: 0
        clip: true

        implicitWidth: root.isExpanded ? expandedContent.implicitWidth : collapsedLayout.implicitWidth
        implicitHeight: root.isExpanded ? expandedContent.implicitHeight : 30
        radius: root.isExpanded ? 20 : 19

        Behavior on color {NumberAnimation {duration: 250; easing.type: Easing.OutCubic}}
        
        Behavior on implicitWidth {NumberAnimation {duration: 250; easing.type: Easing.OutCubic}}
        Behavior on implicitHeight {NumberAnimation {duration: 250; easing.type: Easing.OutCubic}}
        Behavior on radius {NumberAnimation {duration: 250; easing.type: Easing.OutCubic}}
       
        RowLayout{
            id: collapsedLayout
            anchors.centerIn: parent
            spacing: 5
            visible: !root.isExpanded

            ClockWidget {}
        }

        TapHandler{
            gesturePolicy: TapHandler.WithinBounds
            
            onTapped: {
                if (!root.isExpanded) {
                    root.isExpanded = true
                }
            }
        }

        ExpandedContent{
            id: expandedContent
            anchors.fill: parent
            visible: root.isExpanded
            
        }
    }

    
}
