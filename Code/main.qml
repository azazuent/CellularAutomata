import QtQuick 2.12
import QtQuick.Window 2.12
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.12
import QtQml 2.12
import QtQuick.Layouts 1.0

Window {
    minimumWidth: 480
    minimumHeight: 270
    width: 640
    height: 360
    visible: true
    title: qsTr("Cellular Automata")
    LinearGradient{
        anchors.fill: parent
        opacity: 0.75
        start: Qt.point(0,0)
        end: Qt.point(width,height)
        gradient: Gradient{
            GradientStop{position: 0.0; color: "#408EC6"}
            GradientStop{position: 0.5; color: "#1E2761"}
            GradientStop{position: 0.8; color: "#7A2048"}
        }
    }

    MatrixDisplay{
        anchors.fill: parent
    }
}
