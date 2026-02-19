pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root
    readonly property string dateTImeShort: {
	Qt.formatDateTime(clock.date, "HH:mm dd/MM")
    }

    SystemClock {
	id: clock
	precision: SystemClock.Seconds
    }
}
