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

    Player {
        id: player;
    }

    Enemy {
        id: enemy;
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            Qt.quit();
        }
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
            case Qt.Key_Right:
            case Qt.Key_Up:
            case Qt.Key_Down:
            case Qt.Key_Space:
                player.move(event.key);
                break;
            }
            board.update();
            event.accepted = true;
        }
    }
}

