import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.0
import QtQml 2.12
import QtQuick.Controls.Material 2.2

import CellAutomata 1.0

Item {
    ColumnLayout{
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.horizontalCenter
        anchors.margins: 10
        anchors.rightMargin: 5
        spacing: 10
        RowLayout{
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 10
            RoundButton {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.preferredWidth: parent.width/2
                highlighted: true
                radius: 10
                text: "Start"
                onClicked: _timer.running = true
                font.pointSize: 10
                enabled: !_timer.running
            }
            RoundButton {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.preferredWidth: parent.width/2
                highlighted: true
                radius: 10
                text: "Stop"
                onClicked: _timer.running = false
                font.pointSize: 10
                enabled: _timer.running
            }
        }
        RowLayout
        {
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 10
            Slider{
                id: _sliderSpeed
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.preferredWidth: parent.width/10*8
                from: 2000
                to: 50
                stepSize: 1
                value: 1000
            }
            TextField{
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.preferredWidth: parent.width/10*2
                validator: IntValidator{bottom: 50; top: 2000}
                text: _sliderSpeed.value
                font.pointSize: 10
                onEditingFinished: _sliderSpeed.value = text
                color: "black"
                onAcceptableInputChanged:
                {
                    if (acceptableInput)
                        color = "black"
                    else
                        color = "red"
                }
            }
        }
        RowLayout{
            spacing: 10
            Layout.fillHeight: true
            Layout.fillWidth: true
            RoundButton {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.preferredWidth: parent.width/2
                highlighted: true
                radius: 10
                text: "Clear"
                onClicked: _display.clear()
                enabled: !_timer.running
                font.pointSize: 10
            }
            RoundButton {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.preferredWidth: parent.width/2
                highlighted: true
                radius: 10
                text: "Random fill"
                onClicked: _display.randomFill()
                enabled: !_timer.running
                font.pointSize: 10
            }
        }
        RowLayout{
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 10
            id: _textFields
            TextField{
                id: _widthField
                Layout.fillHeight: true
                Layout.fillWidth: true
                validator: IntValidator {id: _widthValidator; bottom: 1; top: 100}
                placeholderText: qsTr("Field width")
                text: "10"
                font.pointSize: 10
                enabled: !_timer.running
                color: "black"
                onAcceptableInputChanged:
                {
                    if (acceptableInput)
                        color = "black"
                    else
                        color = "red"
                }
            }
            TextField{
                id: _heightField
                Layout.fillHeight: true
                Layout.fillWidth: true
                validator: IntValidator {id: _heightValidator; bottom: 1; top: 100}
                placeholderText: qsTr("Field height")
                text: "10"
                font.pointSize: 10
                enabled: !_timer.running
                color: "black"
                onAcceptableInputChanged:
                {
                    if (acceptableInput)
                        color = "black"
                    else
                        color = "red"
                }
            }
        }
        RoundButton{
            Layout.fillHeight: true
            Layout.fillWidth: true
            text: "Edit field"
            radius: 10
            highlighted: true
            onClicked:_display.resizeField(_widthField.text, _heightField.text)
            enabled: !_timer.running && _widthField.acceptableInput && _heightField.acceptableInput
            font.pointSize: 10
        }
        TextField{
            id: _ruleField
            Layout.fillHeight: true
            Layout.fillWidth: true
            validator: IntValidator {bottom: 0}
            placeholderText: qsTr("Rule")
            text: "594594"
            font.pointSize: 10
            color: "black"
            enabled: !_timer.running
        }
        RoundButton{
            Layout.fillHeight: true
            Layout.fillWidth: true
            text: "Edit rule"
            radius: 10
            highlighted: true
            onClicked: _display.editRule(_ruleField.text)
            enabled: !_timer.running
            font.pointSize: 10
        }
    }
    CellAutomata{
        id: _display
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.horizontalCenter
        anchors.right: parent.right
        anchors.margins: 10
        anchors.leftMargin: 5
        MouseArea{
            anchors.fill: parent
            onClicked: _display.handleMouseClick(mouseX, mouseY)
            enabled: !_timer.running
        }
    }
    Timer{
        id: _timer
        interval: _sliderSpeed.value
        repeat: true
        onTriggered: _display.launch()
    }
}
