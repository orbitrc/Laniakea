import QtQuick 2.12

import Blusher 0.1

View {
  id: root

  property string text
  property string imageSource: ''
  property Menu menu: null

  width: extensionText.implicitWidth + 10
  height: 30

  Text {
    id: extensionText
    text: root.text
  }

  MouseArea {
    anchors.fill: parent

    onPressed: {
      if (menu != null) {
        menu.open(0, 0);
      }
    }
  }
}
