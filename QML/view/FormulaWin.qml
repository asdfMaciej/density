import QtQuick 2.0
import QtQuick.Controls.Styles 1.2

Item {
    id: formulaArea
    property int textHeight: height/6
    property Note note: null

    Rectangle {
        id : topEmptyArea
        height: formulaArea.height * 0.2
        width: formulaArea.width
        color: "lightgreen"
        visible: false
    }

    Rectangle{
        id : leftEmptyArea
        width: formulaArea.width * 0.2
        height: formulaArea.height
        color: "lightgreen"
        anchors.top: topEmptyArea.bottom
        visible: false
    }

    Text {
        id: densityText
        width: getTextWidth("Density(ρ)")
        text: "Density(ρ) "
        font.pixelSize: formulaArea.textHeight
        font.bold: true
        textFormat: TextEdit.AutoText
        color: "yellow"
        anchors.left: leftEmptyArea.right
        anchors.top: topEmptyArea.bottom
    }

    Text {
        id: equalText
        width: getTextWidth(" = ")
        text: " = "
        font.pixelSize: formulaArea.textHeight
        font.bold: true
        textFormat: TextEdit.AutoText
        color: "yellow"
        anchors {
            left : densityText.right
            top: topEmptyArea.bottom
        }
    }

    Text {
        id: massText
        width: getTextWidth("Mass(m) ")
        text: "Mass(m) "
        font.pixelSize: formulaArea.textHeight
        font.bold: true
        textFormat: TextEdit.AutoText
        color: "yellow"
        anchors.left: equalText.right
        anchors.top: topEmptyArea.bottom

    }

    Text {
        id: divideText
        width: getTextWidth(" /")
        text: " /"
        font.pixelSize: formulaArea.textHeight
        font.bold: true
        textFormat: TextEdit.AutoText
        color: "yellow"
        anchors.left: massText.right
        anchors.top: topEmptyArea.bottom
    }

    Text {
        id: volumeText
        width: getTextWidth("Volume(v)")
        text: "Volume(v)"
        font.pixelSize: formulaArea.textHeight
        font.bold: true
        textFormat: TextEdit.AutoText
        color: "yellow"
        anchors.left: divideText.right
        anchors.top: topEmptyArea.bottom
    }

    TextInput {
        id: densityInput
        width: densityText.width - getTextWidth("gm/c")
        height: densityText.height
        property int numTrails: 0
        anchors {
            left : densityText.left
            top : densityText.bottom
        }
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        color : "red"
        font.bold: true
        text : "0"
        font.pixelSize: formulaArea.textHeight * 0.7
        focus : true
        Rectangle {
            anchors.fill: parent
            opacity: 0.2
            border.color: "red"
        }
        autoScroll: false
        validator: DoubleValidator {
            bottom: 0
            top: 1e10
            decimals: 2
        }
        maximumLength: 9

//        Keys.onEnterPressed: {
//        }
        Keys.onReturnPressed: {
            if(Number(densityInput.text) > 0 && Number(massResultText.text) > 0 && Number(volumeResultText.text) > 0) {
                numTrails++
                if(numTrails <= 3) {
                    if(densityMatching()) {
                        showDensityExperiment(true)
                        readOnly = true
                        numTrails = 0
                    }else{
                        var msg = "Try again"
                        if(numTrails === 2)
                            msg += ". Last chance."
                        else if(numTrails === 3) {
                            numTrails = 0
                            parentReset()
                        }

                        noteCalulcateDensity.showNote(msg)
                    }
                }
            }
        }

    }

    Item {
        id : noteCalulcateDensity
        property string initialComment: "Calculate the density. Press Enter key."
        width : 170
        height : 100
        anchors {
            top : densityInput.bottom
            left : densityInput.left
            leftMargin: -30
        }

        function showNote(text) {
            if(note !== null)
                note.text =text
            else {
                note = Qt.createQmlObject(
                    "Note{ \n" +
                    "rotation : 180\n" +
                    "textTopMargin: 10\n" +
                    "textLeftMargin: 30\n" +
                    "textWidth: 100\n" +
                    "textHeight: 100\n" +
                    "anchors.fill: parent\n" +
                    "text : \""+ text + "\"}\n" , noteCalulcateDensity, "note")
            }
        }
    }


    Text {
        id : densityResultUnits
        height : densityInput.height
        width : getTextWidth("gm/cm3")
        text: " gm/cm3"
        color: "black"
        anchors {
            left : densityInput.right
            top : densityInput.top
        }
        font.pixelSize: formulaArea.textHeight  * 0.7
        textFormat: TextEdit.AutoText
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter

    }


    Text {
        id: massResultText
        width: massText.width - getTextWidth("gm")
        height: massText.height
        text: "0"
        font.pixelSize: formulaArea.textHeight  * 0.7
        textFormat: TextEdit.AutoText
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: "red"
        font.bold: true
        Rectangle {
            anchors.fill: parent
            opacity: 0.2
            border.color: "red"
        }
        anchors {
            left : massText.left
            top : massText.bottom
        }
    }

    Text {
        id : massResultUnits
        height : massResultText.height
        width : getTextWidth("gm")
        text: " gm"
        color: "black"
        anchors {
            left : massResultText.right
            top : massResultText.top
        }
        font.pixelSize: formulaArea.textHeight  * 0.7
        textFormat: TextEdit.AutoText
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter

    }

    Text {
        id: volumeResultText
        width: volumeText.width - getTextWidth("cm3")
        height: volumeText.height
        text: "0"
        font.pixelSize: formulaArea.textHeight  * 0.7
        textFormat: TextEdit.AutoText
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: "red"
        font.bold: true
        Rectangle {
            anchors.fill: parent
            opacity: 0.2
            border.color: "red"
        }
        anchors {
            left : volumeText.left
            top : volumeText.bottom
        }
    }

    Text {
        id : volumeResultUnits
        height : volumeResultText.height
        width : getTextWidth("cm3")
        text: " cm3"
        color: "black"
        anchors {
            left : volumeResultText.right
            top : volumeResultText.top
        }
        font.pixelSize: formulaArea.textHeight  * 0.7
        textFormat: TextEdit.AutoText
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter

    }


    function getTextWidth(text) {
        return (text.length) * (formulaArea.textHeight * 0.8)
    }

    function updateVolume(volume) {
        volumeResultText.text = volume.toString()
    }

    function updateWeight(mass) {
        massResultText.text = mass.toString()
    }

    function densityMatching() {
        if(Number(densityInput.text) > 0 && Number(massResultText.text) > 0 && Number(volumeResultText.text) > 0) {
            var calculatedDensity = Number(massResultText.text)/Number(volumeResultText.text)
            calculatedDensity = Math.round(Math.floor(calculatedDensity * 100)/10)/10
            var inputDensity = Number(densityInput.text);
            inputDensity = Math.round(Math.floor(inputDensity * 100)/10)/10
            if(inputDensity == calculatedDensity)
                return true
        }
        return false
    }

    function getWeight() {
        return massResultText.text
    }

    function getVolume() {
       return volumeResultText.text
    }

    function getDensity() {
        return densityInput.text
    }

    function getNote() {
        noteCalulcateDensity.showNote(noteCalulcateDensity.initialComment)
        return note
    }

    function parentReset() {
        resetAll(true)
    }

    function reset() {
        densityInput.numTrails = 0
        densityInput.text = "0"
        massResultText.text = "0"
        volumeResultText.text = "0"
        densityInput.readOnly = false
    }
}
