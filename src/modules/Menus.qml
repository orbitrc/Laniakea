pragma Singleton
import QtQuick 2.12

import Blusher 0.1

Item {
  property string msg: 'Menus.msg: "hello"'
  property Menu systemMenus: Menu {
    title: 'System'
    type: Menu.MenuType.SubMenu
    MenuItem {
      title: 'Preferences'
    }
  }
}
