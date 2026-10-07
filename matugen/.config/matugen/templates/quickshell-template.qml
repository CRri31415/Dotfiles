pragma Singleton
import QtQuick

QtObject{
    readonly property color onSecondary: "{{colors.on_secondary.default.hex}}"
    readonly property color onSurface: "{{colors.on_surface.default.hex}}"
    readonly property color surfaceColor: "{{colors.surface.default.hex}}"
}
