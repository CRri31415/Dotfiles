import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland

import "./module"

PanelWindow{
    id: root
    
    anchors{
        top: true
        left: true
        right: true
    }
    
    implicitHeight: isExpanded ? 300 : 32
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
    
    Rectangle {
        id: islandBar
        anchors.top: parent.top
        anchors.topMargin: root.isExpanded ? 0 : 4
        anchors.horizontalCenter: parent.horizontalCenter

        color: root.isExpanded ? Colors.surfaceColor : Colors.onSecondary
        border.width: 0
        clip: true

        implicitWidth: root.isExpanded ? expandedContent.implicitWidth : collapsedLayout.implicitWidth
        implicitHeight: root.isExpanded ? expandedContent.implicitHeight : 24
        radius: root.isExpanded ? 20 : 10

        Behavior on color {ColorAnimation {duration: 250}}
        
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

        ExpandedContent {
            id: expandedContent
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            visible: root.isExpanded
        }
    }

    Rectangle {
        id: workspaceBar
        anchors.top: parent.top
        anchors.topMargin: 4
        anchors.leftMargin: 4
        anchors.left: parent.left

        color: Colors.onSecondary
        border.width: 0

        implicitWidth: workspaceRow.implicitWidth + 24
        implicitHeight: 24
        radius: 5
        
        Behavior on implicitWidth {NumberAnimation {duration: 250; easing.type: Easing.OutCubic}}
        
        RowLayout {
            id: workspaceRow
            anchors.centerIn: parent
            Repeater {
                model: Hyprland.workspaces

                delegate: Rectangle {
                    required property var modelData
                    property bool isActive: Hyprland.focusedWorkspace === modelData

                    implicitWidth: isActive ? 32 : 16
                    implicitHeight: 16
                    radius: 5

                    Behavior on implicitWidth {NumberAnimation {duration: 250; easing.type: Easing.OutQuad}}
                    Behavior on color {ColorAnimation {duration: 250}}

                    color: isActive ? Colors.primaryColor : Colors.secondaryColor

                    
                    Text {
                        text: {
                            let wsName = String(modelData.name || modelData.id || "")
                            return wsName.length > 0 ? wsName.charAt(0).toUpperCase() : ""
                        }

                        font.pixelSize: 10
                        font.bold: isActive
                        color: Colors.surfaceColor
                        horizontalAlignment: Text.AlignMiddle
                        anchors.centerIn: parent
                    }
                }
            }
        }
    }
}
