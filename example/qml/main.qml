import QtQuick
import QtQuick.Controls

ApplicationWindow {
  width: 400
  height: 400
  visible: true

  Image { 
    id: playMat
    source: "https://www.myfreetextures.com/wp-content/uploads/2012/05/2011-06-11-09606.jpg"
    anchors.fill: parent

    Rectangle {
      id: token
      width: 50
      height: 50
      anchors.centerIn: parent
      radius: width / 2
      color: "blue"

      MouseArea {
        anchors.fill: parent
        onClicked: token.rotation += 45
      }
    }
  }
}
