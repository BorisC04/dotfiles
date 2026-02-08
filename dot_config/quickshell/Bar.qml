import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import Quickshell.Io

Scope {
    PanelWindow {
	id: baseBar

	property int cpuUsage: 0
	property var lastCpuIdle: 0
	property var lastCpuTotal:0
	property int memUsage: 0
	property string activeWindow: "Window"

	Process {
	    id: cpuProc
	    command: ["sh", "-c", "head -1 /proc/stat"]


	    stdout: SplitParser {
		onRead: data => {
		    var p = data.trim().split(/\s+/)
		    var idle = parseInt(p[4]) + parseInt(p[5])
		    var total = p.slice(1, 8).reduce((a, b) => a + parseInt(b), 0)
		    if (baseBar.lastCpuTotal > 0) {
			baseBar.cpuUsage = Math.round(100 * (1 - (idle - baseBar.lastCpuIdle) / (total - baseBar.lastCpuTotal)))
		    }
		    baseBar.lastCpuTotal = total
		    baseBar.lastCpuIdle = idle
		}
	    }
	}

	Process {
	    id: memProc
	    command: ["sh", "-c", "free | grep Mem"]
	    stdout: SplitParser {
		onRead: data => {
		    var parts = data.trim().split(/\s+/)
		    var total = parseInt(parts[1]) || 1
		    var used = parseInt(parts[2]) || 0
		    baseBar.memUsage = Math.round(100 * used / total)
		}
	    }
	    Component.onCompleted: running = true
	}

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

	Timer {
	    interval: 2000
	    running: true
	    repeat: true
	    onTriggered: {
		cpuProc.running = true
		memProc.running = true
	    }
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
	implicitHeight: 30
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
	    anchors.right: parent.right

	    Rectangle {
		Layout.fillWidth:true
	    }

	    Text {
		text: "CPU: " + baseBar.cpuUsage + "%"
		Layout.alignment: Qt.AlignHCenter
		color: root.colYellow
		font { family: root.fontFamily; pixelSize: root.fontSize; bold: true }
	    }

	    Rectangle { width: 1; height: 16; color: root.colMuted }

	    Text {
		text: "Mem: " + baseBar.memUsage + "%"
		Layout.alignment: Qt.AlignHCenter
		color: root.colPurple
		font { family: root.fontFamily; pixelSize: root.fontSize; bold: true }
	    }

	    Rectangle { width: 1; height: 16; color: root.colMuted }

	    Text {
		id: clock
		text: Qt.formatDateTime(new Date(), "MMM dd HH:mm")
		Layout.alignment: Qt.AlignHCenter
		color: root.colCyan
		font { family: root.fontFamily; pixelSize: root.fontSize; bold: true }

		Timer {
		    interval: 1000
		    running: true
		    repeat: true
		    onTriggered: clock.text = Qt.formatDateTime(new Date(), "MMM dd, HH:mm")
		}
	    }
	}
    }
}
