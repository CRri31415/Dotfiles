import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Services.Pipewire

import "./module"

PanelWindow{
    id: root
    
    anchors{
        top: true
        left: true
        right: true
    }
    
    implicitHeight: root.isExpanded ? 300 : 32
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

    function pipewireLinkGroups() {
        return Pipewire.linkGroups?.values ?? []
    }

    function nodeHasType(node, type) {
        return node && node.type !== undefined && (node.type === type || (node.type & type) === type)
    }

    function nodePropertyText(node) {
        const properties = node?.properties ?? {}
        return [
            properties["media.class"] ?? "",
            properties["node.name"] ?? "",
            properties["node.description"] ?? "",
            properties["node.nick"] ?? "",
            properties["application.name"] ?? "",
            node?.name ?? "",
            node?.description ?? "",
            node?.nickname ?? ""
        ].join(" ").toLowerCase()
    }

    function textHasAny(text, needles) {
        for (let i = 0; i < needles.length; i += 1) {
            if (text.indexOf(needles[i]) !== -1) return true
        }
        return false
    }

    function nodeLooksLikeVideoSource(node) {
        const text = nodePropertyText(node)
        return nodeHasType(node, PwNodeType.VideoSource) ||
            (nodeHasType(node, PwNodeType.Video) && nodeHasType(node, PwNodeType.Source)) ||
            text.indexOf("video/source") !== -1 ||
            text.indexOf("video source") !== -1 ||
            text.indexOf("v4l2") !== -1 ||
            text.indexOf("camera") !== -1
    }

    
    function nodeLooksLikeMicrophoneSource(node) {
        const text = nodePropertyText(node)
        return nodeHasType(node, PwNodeType.AudioSource) ||
            (nodeHasType(node, PwNodeType.Audio) && nodeHasType(node, PwNodeType.Source)) ||
            text.indexOf("audio/source") !== -1 ||
            text.indexOf("audio source") !== -1 ||
            text.indexOf("alsa_input") !== -1 ||
            textHasAny(text, ["microphone", "mic", "input"])
    }
    
    function nodeLooksLikeAudioInputStream(node) {
        const text = nodePropertyText(node)
        return nodeHasType(node, PwNodeType.AudioInStream) ||
            (nodeHasType(node, PwNodeType.Audio) && nodeHasType(node, PwNodeType.Stream)) ||
            text.indexOf("stream/input/audio") !== -1 ||
            text.indexOf("audio/input") !== -1 ||
            text.indexOf("input audio") !== -1 ||
            text.indexOf("source-output") !== -1 ||
            text.indexOf("capture") !== -1
    }
    
    function nodeLooksLikeScreenCapture(node) {
        const text = nodePropertyText(node)
        return text.indexOf("video/writer") !== -1 ||
            text.indexOf("stream/output/video") !== -1 ||
            text.indexOf("desktop-capture") !== -1 ||
            text.indexOf("hyprland") !== -1 && text.indexOf("share") !== -1
    }
    
    function detectMicrophoneActivity() {
        const groups = root.pipewireLinkGroups();

        for (let i = 0; i < groups.length; i += 1) {
            const group = groups[i];

            const sourceIsMic = root.nodeLooksLikeMicrophoneSource(group?.source);
            const targetIsMic = root.nodeLooksLikeMicrophoneSource(group?.target);
            const sourceIsStream = root.nodeLooksLikeAudioInputStream(group?.source);
            const targetIsStream = root.nodeLooksLikeAudioInputStream(group?.target);
            
            if ((sourceIsMic && (targetIsStream || !targetIsMic)) || (targetIsMic && (sourceIsStream || !sourceIsMic))) {
                return true;
            }        
        }

        return false;
    }
    
    function detectVideoActivity() {
        const groups = root.pipewireLinkGroups();

        for (let i = 0; i < groups.length; i += 1) {
            const group = groups[i];

            if (root.nodeLooksLikeVideoSource(group?.source) || root.nodeLooksLikeVideoSource(group?.target)) {
                return true;
            }        
        }

        return false;
    }
    
    Rectangle {
        id: privacyIndicatorBar
        
        readonly property bool isMicActive: root.detectMicrophoneActivity()
       
        readonly property bool isCamActive: root.detectVideoActivity()
        
        readonly property bool isPrivacyActive: isMicActive || isCamActive
        
        implicitWidth: isPrivacyActive ? privacyRow.implicitWidth + 16 : 0
        implicitHeight: 24
        radius: 5
        
        anchors.top: parent.top
        anchors.topMargin: 4
        anchors.rightMargin: 4
        anchors.right: parent.right

        color: Colors.onSecondary
        border.width: 0

        Behavior on implicitWidth {NumberAnimation {duration: 250; easing.type: Easing.OutCubic}}

        opacity: isPrivacyActive ? 1.0 : 0.0

        RowLayout {
            id: privacyRow
            anchors.centerIn: parent
            spacing: 8

            Rectangle {
                visible: privacyIndicatorBar.isMicActive
                implicitWidth: 24
                implicitHeight: 24
                radius: 12
                color: Colors.primaryColor
            }

            Rectangle {
                visible: privacyIndicatorBar.isCamActive
                implicitWidth: 24
                implicitHeight: 24
                radius: 12
                color: Colors.secondaryColor
            }
        }
    }
}
