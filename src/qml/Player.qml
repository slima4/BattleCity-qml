import QtQuick 2.0

import "logic.js" as Logic

Rectangle {
    property int id: 3;
    Tank {
        id: tank;
    }

    function update()
    {
        tank.update();
    }

    Component.onCompleted:
    {
        tank.id = 3;
        tank.pos = Qt.point(16,8);
        tank.move(Logic.directionType.None);
    }

    function move(key)
    {
        switch(key)
        {
        case Qt.Key_Left:
            tank.move(Logic.directionType.Left);
            break;
        case Qt.Key_Right:
            tank.move(Logic.directionType.Right);
            break;
        case Qt.Key_Up:
            tank.move(Logic.directionType.Up);
            break;
        case Qt.Key_Down:
            tank.move(Logic.directionType.Down);
            break;
        case Qt.Key_Space:
            tank.shoot();
            break;
        }
    }
}
