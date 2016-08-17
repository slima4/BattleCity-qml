import QtQuick 2.0

import "logic.js" as Logic

Rectangle {
    Tank {
        id: enemy;
    }

    Component.onCompleted:
    {
        enemy.id = 3;
        enemy.pos = Qt.point(0,10);
        enemy.move(Logic.directionType.None);
    }
}
