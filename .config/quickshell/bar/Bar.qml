import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import Quickshell.Io

Scope {
    PanelWindow {
	id: baseBar

	property string activeWindow: "Window"

	Process {
	    id: windowProc
	    command: ["sh", "-c", "hyprctl activewindow -j | jq -r '.title // empty'"]
	    stdout: SplitParser {
		onRead: data => {
		    if (data && data.trim()) {
			baseBar.activeWindow = data.trim()
		    }
		}
	    }
	    Component.onCompleted: running = true
	}


	Connections {
	    target: Hyprland
	    function onRawEvent(event) {
		windowProc.running = true
	    }
	}

	Timer {
	    interval: 200
	    running: true
	    repeat: true
	    onTriggered: {
		windowProc.running = true
	    }
	}

	anchors {
	    top: true
	    left: true
	    right: true
	}
	implicitHeight: 40
	color: root.colBg

	
	Text {
	    text: baseBar.activeWindow
	    color: root.colFg

	    anchors {
		margins: 8
		left: parent.left
		top: parent.top
		bottom: parent.bottom
		right: workspaces.left
	    }

	    font {
		pixelSize: root.fontSize - 2
		family: root.fontFamily
		bold: true
	    }

	    elide: Text.ElideRight
	}

	RowLayout {
	    id: workspaces
	    anchors {
		horizontalCenter: parent.horizontalCenter
		top: parent.top
		bottom:parent.bottom
		margins: 8
	    }
	    spacing: 16

	    Repeater {
		model: 10
	
		Text {
		    property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
		    property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
	
		    visible: isActive || index < 5 || (ws ? true : false)
		    text: index + 1
		    color: isActive ? root.colCyan : (ws ? root.colBlue : root.colMuted)
		    font { family: root.fontFamily; pixelSize: root.fontSize; bold: true }
	
		    MouseArea {
			anchors.fill: parent
			onClicked: Hyprland.dispatch("workspace " + (index + 1))
		    }
		}
	    }
	}

	RowLayout {
	    anchors.top: parent.top
	    anchors.bottom: parent.bottom
	    anchors.right: parent.right
	    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

	    Text {
		text: "CPU: " + Indicators.cpuUsage + "%"
		color: root.colYellow
		font { family: root.fontFamily; pixelSize: root.fontSize; bold: true }
	    }

	    Rectangle { width: 1; height: 16; color: root.colMuted }

	    Text {
		text: "Mem: " + Indicators.memUsage + "%"
		color: root.colPurple
		font { family: root.fontFamily; pixelSize: root.fontSize; bold: true }
	    }

	    Rectangle { width: 1; height: 16; color: root.colMuted }

	    Text {

		id: clock
		color: root.colCyan
		font { family: root.fontFamily; pixelSize: root.fontSize; bold: true }

		text: Clock.dateTImeShort
	    }
	}
    }
}
