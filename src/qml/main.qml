import QtQuick 2.3
import QtQuick.Window 2.2

import "logic.js" as Logic

Window {
    visible: true
    width: 480;
    height: 360;
    color: "black";

    minimumHeight: height;
    minimumWidth: width;
    maximumHeight: height;
    maximumWidth: width;
    title: qsTr("Battle city");

    property var bulletArr: [];
    property int direct: Logic.directionType.Up;

    Board {
        id: board;
    }

    Tank {
        id: player;
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            Qt.quit();
        }
    }

    Component.onCompleted:
    {
        player.pos = Qt.point(0,0);
        player.move(Logic.directionType.None);
    }

    Bullet {
        id: bullet;
    }

    Timer {
        id: gameLoop;
        repeat: true;
        interval: 300; running: true;
        onTriggered: {
            player.update();
            board.update();
        }
    }

    Rectangle {
        focus: true
        Keys.onPressed: {
            switch(event.key)
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
            board.update();
            event.accepted = true;
        }
    }
}

