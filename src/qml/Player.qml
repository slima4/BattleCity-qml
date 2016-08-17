import QtQuick 2.0

import "logic.js" as Logic

Rectangle {
    Tank {
        id: player;
    }

    function update()
    {
        player.update();
    }

    Component.onCompleted:
    {
        player.pos = Qt.point(0,0);
        player.move(Logic.directionType.None);
    }

    function move(key)
    {
        switch(key)
        {
        case Qt.Key_Left:
            player.move(Logic.directionType.Left);
            break;
        case Qt.Key_Right:
            player.move(Logic.directionType.Right);
            break;
        case Qt.Key_Up:
            player.move(Logic.directionType.Up);
            break;
        case Qt.Key_Down:
            player.move(Logic.directionType.Down);
            break;
        case Qt.Key_Space:
            player.shoot();
            break;
        }
    }
}
