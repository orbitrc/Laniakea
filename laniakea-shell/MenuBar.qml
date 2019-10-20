import QtQuick 2.12

import Blusher 0.1

Rectangle {
  id: menuBar

  // width: 1920
  // height: 30

  property string clock: ''

  signal clockClicked()
  signal openMenu(var items)

  color: "#181818"

  // Kill button
  MouseArea {
    width: 24
    x: 300
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    hoverEnabled: true
    Rectangle {
      id: _testRect
      anchors.fill: parent
      color: "red"
    }
    onClicked: {
      Shell.quit();
    }
    onEntered: {
      _testRect.color = "blue";
    }
    onExited: {
      _testRect.color = "red";
    }
  }

  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: {
//      root.clock = new Date();
      let now = new Date();
      let text = '';
      let dateString = {
        hour: now.getHours().toString().padStart(2, '0'),
        minute: now.getMinutes().toString().padStart(2, '0'),
        second: now.getSeconds().toString().padStart(2, '0')
      };

      text += dateString.hour + ':' + dateString.minute + ':' + dateString.second;
      menuBar.clock = text;
    }
  }

  //=================
  // Menu bar menus
  //=================
  Row {
    id: menuBarMenus

    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.left: parent.left

    //================
    // System menu
    //================
    Item {
      width: 50
      anchors.top: parent.top
      anchors.bottom: parent.bottom
      Text {
        text: 'system'
        color: "white"
      }
      MouseArea {
        anchors.fill: parent

        onClicked: {
          print('openMenu signal sent');
          menuBar.openMenu({ 'path:' : '/preferences' });
        }
      }
    }
  }

  //==========================
  // Menu bar extensions
  //==========================
  Row {
    id: menuBarExtensions

    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.right: parent.right

    // Clock
    Item {
      width: 90
      anchors.top: parent.top
      anchors.bottom: parent.bottom
      Text {
        text: menuBar.clock
        color: "white"
      }
      MouseArea {
        anchors.fill: parent
        onClicked: {
          print('clock clicked');
          menuBar.clockClicked();
        }
      }

//      onTriggered: {
//      }
    }
  }
}